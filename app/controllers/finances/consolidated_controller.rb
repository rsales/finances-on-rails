class Finances::ConsolidatedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_family_group

  def index
    @year = params[:year]&.to_i || Date.today.year
    @consolidated_data = ConsolidatedDataService.new(@family_group, @year).call

    # @chart_data = prepare_chart_data(@consolidated_data)
    @chart_data = {
      receitas: [ 5, 3, 7, 3, 7, 2, 2, 5, 2, 6, 2, 7 ],
      gastos_fixos: [ 3, 7, 5, 6, 5, 2, 4, 7, 0, 6, 4, 2 ],
      gastos_variaveis: [ 2, 1, 6, 4, 3, 4, 3, 7, 7, 2, 0, 5 ],
      investimentos: [ 2, 4, 5, 3, 1, 4, 4, 5, 5, 5, 4, 1 ]
    }
  end

  private

  def prepare_chart_data(consolidated_data)
    {
      receitas: (1..12).map { |month| consolidated_data["Receitas"]&.fetch(month, { total: 0 })[:total] },
      gastos_fixos: (1..12).map { |month| consolidated_data["Gastos Fixos"]&.fetch(month, { total: 0 })[:total] },
      gastos_variaveis: (1..12).map { |month| consolidated_data["Gastos Variáveis"]&.fetch(month, { total: 0 })[:total] },
      investimentos: (1..12).map { |month| consolidated_data["Investimentos"]&.fetch(month, { total: 0 })[:total] }
    }
  end

  def set_and_authorize_family_group
    @family_group = current_user.family_groups.find_by(id: params[:family_group_id])
    unless @family_group
      redirect_to finances_home_path, alert: "Você não tem permissão para acessar este grupo familiar ou ele não existe."
    end
  end
end
