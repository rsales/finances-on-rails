class Finances::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_family_group
  before_action :set_transaction, only: [ :show, :edit, :update, :destroy ]
  before_action :set_bank_accounts, only: [ :new_by_category_type, :edit ]
  helper_method :new_url

  CATEGORY_TYPE_MAP = {
    "revenue" => "Receitas",
    "investment" => "Investimentos",
    "fixed-expenses" => "Gastos Fixos",
    "variable-expenses" => "Gastos Variáveis"
  }

  def new_url(params)
    case params
    when "Receitas"
      "revenue"
    when "Investimentos"
      "investment"
    when "Gastos Fixos"
      "fixed-expenses"
    else
      "variable-expenses"
    end
  end

  def index
    if params[:month].present?
      begin
        @month = Date.parse("#{params[:month]}-01")
      rescue ArgumentError => e
        @month = Date.today
      end
    else
      @month = Date.today
    end

    @transactions = @family_group.transactions
    @category_types = CategoryType.all

    if @month
      start_of_month = @month.beginning_of_month
      end_of_month = @month.end_of_month

      @transactions = @transactions.where(month: start_of_month.strftime("%Y-%m")..end_of_month.strftime("%Y-%m"))
    end

    if params[:category_type].present?
      @category_type = params[:category_type] # Captura o parâmetro enviado
      @transactions = @transactions.joins(transaction_category: :category_type)
        .where(category_types: { name: @category_type })
    end

    @totals_by_category_type = CategoryType.all.each_with_object({}) do |category_type, hash|
      total_value = @transactions.joins(:transaction_category)
                                .where(transaction_categories: { category_type_id: category_type.id })
                                .sum(:value)

      hash[category_type.name] = total_value
    end
  end

  def new_by_category_type
    @category_type = CATEGORY_TYPE_MAP[params[:category_type]]

    if @category_type.nil?
      redirect_to finances_transactions_path(@family_group), alert: "Categoria inválida."
      return
    end

    category_type_key = params[:category_type]
    category_type_name = CATEGORY_TYPE_MAP[category_type_key]
    @transaction_categories = TransactionCategory.joins(:category_type)
      .where(category_types: { name: category_type_name })
      .where(family_group_id: @family_group.id)

    @transaction = @family_group.transactions.build
    @month = params[:month] || Date.today.strftime("%Y-%m")

    respond_to do |format|
      format.turbo_stream { render :new_by_category_type }
      format.html { render :new_by_category_type, layout: false }
    end
  end

  def create
    @transaction = @family_group.transactions.build(transaction_params)

    if @transaction.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("transactions-body", partial: "transaction", locals: { transaction: @transaction }),
            turbo_stream.remove("modal-frame"),
            turbo_stream.remove("modal")
          ]
        end
        format.html { redirect_to finances_transactions_path(@family_group), notice: "Transação criada com sucesso." }
      end
    else
      Rails.logger.error @transaction.errors.full_messages.join(", ")
      respond_to do |format|
        format.turbo_stream { render :new_by_category_type }
        format.html { render :new_by_category_type }
      end
    end
  end

  def edit
    @transaction = @family_group.transactions.find(params[:id])
    @transaction_categories = TransactionCategory.joins(:category_type)
      .where(category_types: { id: @transaction.transaction_category.category_type_id })
      .order(:name)

    respond_to do |format|
      format.turbo_stream { render :edit }
      format.html { render :edit }
    end
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to finances_transactions_path(@family_group), notice: "Transação atualizada com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @transaction = @family_group.transactions.find(params[:id])

    if @transaction.subscription
      future_transactions = @family_group.transactions.where("month > ? AND name = ? AND transaction_category_id = ? AND bank_account_id = ?", @transaction.month, @transaction.name, @transaction.transaction_category_id, @transaction.bank_account_id)
      future_transactions.destroy_all
    end

    @transaction.destroy
    respond_to do |format|
      format.turbo_stream { redirect_to finances_transactions_path(@family_group), notice: "Transação excluída com sucesso." }
      format.html { redirect_to finances_transactions_path(@family_group), notice: "Transação excluída com sucesso." }
    end
  end

  def destroy_future
    @transaction = @family_group.transactions.find(params[:id])

    if @transaction.subscription
      future_transactions = @family_group.transactions.where("month > ? AND name = ? AND transaction_category_id = ? AND bank_account_id = ?", @transaction.month, @transaction.name, @transaction.transaction_category_id, @transaction.bank_account_id)
      future_transactions.destroy_all
    end

    respond_to do |format|
      format.turbo_stream { redirect_to finances_transactions_path(@family_group), notice: "Faturas futuras excluídas com sucesso." }
      format.html { redirect_to finances_transactions_path(@family_group), notice: "Faturas futuras excluídas com sucesso." }
    end
  end

  private

  def set_and_authorize_family_group
    @family_group = current_user.family_groups.find_by(id: params[:family_group_id])
    unless @family_group
      redirect_to finances_home_path, alert: "Você não tem permissão para acessar este grupo familiar ou ele não existe."
    end
  end

  def set_bank_accounts
    @bank_accounts = @family_group.users.joins(:bank_accounts).select("bank_accounts.*")
  end

  def set_transaction
    @transaction = @family_group.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(
      :name,
      :value,
      :month,
      :subscription,
      :number_of_installments,
      :current_installment,
      :transaction_category_id,
      :bank_account_id,
      :family_group_id
    )
  end
end
