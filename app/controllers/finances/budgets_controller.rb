class Finances::BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family_group

  # Exibe todos os orçamentos de um determinado family_group
  def index
    # @budgets = @family_group.budgets
    @months = @family_group.budgets.distinct.pluck(:month).sort.reverse
  end

  # Exibe os budgets para o mês selecionado
  def show
    @month = params[:month]
    @budgets = @family_group.budgets.where(month: @month)

    if @budgets.empty?
      redirect_to finances_budget_path(@family_group), alert: "Nenhum orçamento encontrado para o mês #{@month}."
    end
  end
  # def show
  #   # Redireciona para 'index' se o parâmetro 'month' for inválido
  #   unless params[:month].match(/\A\d{4}-\d{2}\z/)
  #     redirect_to finances_budget_path(@family_group), alert: "Mês inválido."
  #     return
  #   end

  #   @month = params[:month]
  #   @budgets = @family_group.budgets.where(month: @month)
  # end

  # Exibe o formulário de criação de orçamento
  # def new
  #   @categories = @family_group.transaction_categories
  #   @month = params[:month] || Time.now.strftime("%Y-%m")
  #   @budgets = @categories.map do |category|
  #     Budget.new(transaction_category: category, value: 0, month: @month, family_group: @family_group)
  #   end
  # end
  def new
    @categories = @family_group.transaction_categories
    @month = Time.now.strftime("%Y-%m") # Mês atual como padrão
    @budgets = @categories.map do |category|
      Budget.new(transaction_category: category, value: 0, month: @month, family_group: @family_group)
    end
  end

  # Cria o orçamento
  def create
    @month = params[:month]
    @categories = @family_group.transaction_categories
    budgets_params = params[:budgets]

    budgets = budgets_params.map do |budget_param|
      Budget.new(
        value: budget_param[:value],
        month: @month,
        transaction_category_id: budget_param[:transaction_category_id],
        family_group: @family_group
      )
    end

    if budgets.all?(&:valid?)
      budgets.each(&:save!)
      redirect_to finances_budget_path(@family_group), notice: "Orçamentos criados com sucesso!"
    else
      @budgets = budgets
      render :new, alert: "Erro ao criar orçamentos."
    end
  end

  # Exibe o formulário para edição dos orçamentos do mês atual
  def edit
    @current_month = Time.now.strftime("%Y-%m")
    @budgets = @family_group.budgets.where(month: @current_month)
  end

  # Atualiza os orçamentos do mês atual
  def update
    @current_month = Time.now.strftime("%Y-%m")
    @budgets = @family_group.budgets.where(month: @current_month)

    # Atualiza cada orçamento individualmente
    success = true
    @budgets.each do |budget|
      budget_params = params[:budgets].find { |b| b[:id].to_i == budget.id }
      success &&= budget.update(value: budget_params[:value]) if budget_params
    end

    if success
      redirect_to finances_budget_path(@family_group), notice: "Orçamentos atualizados com sucesso!"
    else
      flash.now[:alert] = "Erro ao atualizar os orçamentos."
      render :edit
    end
  end

  private

  # Define o grupo familiar para os budgets
  def set_family_group
    @family_group = current_user.family_groups.find(params[:family_group_id])
  end

  # Permite parâmetros para um único orçamento
  def budget_params
    params.require(:budget).permit(:value, :month, :transaction_category_id)
  end
end
