class Finances::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_family_group
  before_action :set_transaction, only: [ :show, :edit, :update, :destroy ]
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

    respond_to do |format|
      format.turbo_stream { render :new_by_category_type }
      format.html { render :new_by_category_type, layout: false }
    end
  end

  def create
    @transaction = @family_group.transactions.build(transaction_params)

    if @transaction.save
      respond_to do |format|
        format.turbo_stream { redirect_to finances_transactions_path(@family_group), notice: "Transação criada com sucesso." }
        format.html { redirect_to finances_transactions_path(@family_group), notice: "Transação criada com sucesso." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :new }
        format.html { render :new }
      end
    end
  end

  def edit
    @transaction = @family_group.transactions.find(params[:id])
    @transaction_categories = TransactionCategory.joins(:category_type)
      .where(category_types: { id: @transaction.transaction_category.category_type_id })
      .order(:name)
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to finances_transactions_path(@family_group), notice: "Transação atualizada com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @transaction.destroy
    redirect_to finances_transactions_path(@family_group), notice: "Transação excluída com sucesso."
  end

  private

  def set_and_authorize_family_group
    @family_group = current_user.family_groups.find_by(id: params[:family_group_id])
    unless @family_group
      redirect_to finances_home_path, alert: "Você não tem permissão para acessar este grupo familiar ou ele não existe."
    end
  end

  def set_transaction
    @transaction = @family_group.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:description, :amount, :transaction_category_id, :date)
  end
end
