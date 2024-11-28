class Finances::DashboardsController < ApplicationController
  before_action :authenticate_user!  # Garantir que o usuário esteja autenticado

  def show
    # Busca o FamilyGroup pelo ID
    @family_group = FamilyGroup.find(params[:family_group_id])

    # Caso o FamilyGroup não seja encontrado, redirecionar ou exibir uma mensagem de erro
  rescue ActiveRecord::RecordNotFound
    redirect_to finances_path, alert: "Grupo de Família não encontrado."
  end
end
