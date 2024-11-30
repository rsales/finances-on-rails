class Finances::BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family_group

  def index
    @months = @family_group.budgets.distinct.pluck(:month).sort.reverse
  end
  def show
    @month = params[:month]
    @budgets = @family_group.budgets.includes(:transaction_category).where(month: @month)

    if @budgets.empty?
      redirect_to finances_budget_path(@family_group), alert: "Nenhum orçamento encontrado para o mês #{@month}."
    else
      @grouped_budgets = @budgets.group_by { |budget| budget.transaction_category.category_type }
    end
  end

  def new
    @month = params[:month] || Date.today.strftime("%Y-%m")

    @grouped_categories = @family_group.transaction_categories.group_by(&:category_type)

    @categories = @family_group.transaction_categories.map do |category|
      Budget.new(transaction_category: category, month: @month, value: 0)
    end
  end

  def create
    budgets = budgets_params.map do |budget_param|
      @family_group.budgets.new(budget_param)
    end

    if budgets.all?(&:save)
      redirect_to finances_budget_path(@family_group), notice: "Orçamentos criados com sucesso!"
    else
      error_messages = budgets.map { |budget| budget.errors.full_messages }.flatten
      flash[:alert] = "Erro ao criar os orçamentos: #{error_messages.join(', ')}"
      @month = params[:month]
      @categories = budgets
      render :new
    end
  end

  def edit
    @current_month = Time.now.strftime("%Y-%m")
    @budgets = @family_group.budgets.where(month: @current_month)

    @grouped_budgets = @budgets.group_by { |budget| budget.transaction_category.category_type }
  end

  def update
    @month = params[:month]
    @budgets = @family_group.budgets.where(month: @month)

    if @budgets.empty?
      redirect_to finances_budget_path(@family_group), alert: "Nenhum orçamento encontrado para o mês #{@month}."
      return
    end

    # Processa os parâmetros de orçamento para atualizar
    success = budgets_params.all? do |budget_param|
      budget = @budgets.find { |b| b.id == budget_param[:id].to_i }
      budget && budget.update(budget_param)
    end

    if success
      redirect_to finances_budget_path(@family_group, month: @month), notice: "Orçamentos atualizados com sucesso!"
    else
      flash.now[:alert] = "Erro ao atualizar os orçamentos. Verifique os campos e tente novamente."
      render :edit
    end
  end


  private

  # Define o grupo familiar para os budgets
  def set_family_group
    @family_group = current_user.family_groups.find(params[:family_group_id])
  end

  # Permite parâmetros para um único orçamento
  def budgets_params
    params.require(:budgets).permit(
      # Permite múltiplos orçamentos, cada um com esses atributos
      budgets: [ :id, :transaction_category_id, :value, :month ]
    )[:budgets].values
  end
end
