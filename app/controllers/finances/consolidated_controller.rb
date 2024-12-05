class Finances::ConsolidatedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_family_group

  def index
    # Define o ano com base no parâmetro da URL ou usa o ano atual como padrão
    @year = params[:year]&.to_i || Date.today.year

    # Passa o parâmetro do ano para o serviço
    @consolidated_data = ConsolidatedDataService.new(@family_group, @year).call
  end

  private

  def set_and_authorize_family_group
    @family_group = current_user.family_groups.find_by(id: params[:family_group_id])
    unless @family_group
      redirect_to finances_home_path, alert: "Você não tem permissão para acessar este grupo familiar ou ele não existe."
    end
  end
end
