class Finances::BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family_group

  # Exibe a lista de orçamentos
  def index
    @budgets = @family_group.budgets
  end

  # Cria um novo orçamento
  def new
    @budget = @family_group.budgets.new
  end

  # Cria o orçamento na base de dados
  def create
    @budget = @family_group.budgets.new(budget_params)
    if @budget.save
      redirect_to finances_budget_path(@family_group), notice: "Orçamento criado com sucesso!"
    else
      render :new
    end
  end

  private

  def set_family_group
    @family_group = current_user.family_groups.find(params[:family_group_id])
  end

  def budget_params
    params.require(:budget).permit(:name, :amount, :start_date, :end_date)
  end
end
