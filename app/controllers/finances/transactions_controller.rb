class Finances::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_family_group
  before_action :set_transaction, only: [ :show, :edit, :update, :destroy ]

  CATEGORY_TYPE_MAP = {
    "revenue" => "Receitas",
    "investment" => "Investimentos",
    "fixed-expenses" => "Gastos Fixos",
    "variable-expenses" => "Gastos Variáveis"
  }

  # def index
  #   @transactions = @family_group.transactions
  # end
  def index
    # Pegando o mês da URL (caso o mês não seja selecionado, será nil)
    @month = params[:month].to_i

    # Filtrar transações de acordo com o mês, caso um mês tenha sido selecionado
    @transactions = @family_group.transactions
    if @month.present? && @month.between?(1, 12)
      # Filtra as transações para o mês selecionado
      @transactions = @transactions.where("extract(month from date) = ?", @month)
    end
  end

  def new
    @transaction = @family_group.transactions.build
    @transaction_categories = TransactionCategory.all.order(:name)
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
      format.turbo_stream
      format.html { render :new }
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
