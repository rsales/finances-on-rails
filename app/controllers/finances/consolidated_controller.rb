class Finances::ConsolidatedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_family_group

  def index
    @year = params[:year]&.to_i || Date.today.year
    @service = ConsolidatedDataService.new(@family_group, @year)
    @consolidated_data = @service.call

    @chart_data = prepare_chart_data(@consolidated_data)
  end

  def prepare_chart_data(consolidated_data)
    {
      receitas: (1..12).map { |month| sum_monthly_totals(consolidated_data["Receitas"], month) },
      gastos_fixos: (1..12).map { |month| sum_monthly_totals(consolidated_data["Gastos Fixos"], month) },
      gastos_variaveis: (1..12).map { |month| sum_monthly_totals(consolidated_data["Gastos Variáveis"], month) },
      investimentos: (1..12).map { |month| sum_monthly_totals(consolidated_data["Investimentos"], month) }
    }
  end

  private

  def sum_monthly_totals(category_data, month)
    return 0 unless category_data

    category_data.values.reduce(0) do |sum, subcategory|
      sum + (subcategory[month] || 0)
    end
  end

  def set_and_authorize_family_group
    @family_group = current_user.family_groups.find_by(id: params[:family_group_id])
    unless @family_group
      redirect_to finances_home_path, alert: "Você não tem permissão para acessar este grupo familiar ou ele não existe."
    end
  end
end
