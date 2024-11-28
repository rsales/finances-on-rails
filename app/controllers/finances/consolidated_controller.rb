class Finances::ConsolidatedController < ApplicationController
  before_action :authenticate_user!  # Garante que o usuário esteja autenticado
  before_action :set_family_group   # Carrega o FamilyGroup com base no :family_group_id

  def index
    # Aqui você busca ou calcula os dados consolidados associados ao grupo familiar
    @consolidated_data = ConsolidatedDataService.new(@family_group).call
  end

  private

  # Método para carregar o grupo familiar com base no :family_group_id
  def set_family_group
    @family_group = current_user.family_groups.find(params[:family_group_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to finances_home_path, alert: "Grupo familiar não encontrado."
  end
end
