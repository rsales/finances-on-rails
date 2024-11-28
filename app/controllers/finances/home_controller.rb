class Finances::HomeController < ApplicationController
  before_action :authenticate_user!  # Garante que o usuário esteja autenticado

  def index
    # Buscar todos os family_groups do usuário logado
    @family_groups = current_user.family_groups
    # Passar o current_user para a view, embora ele já esteja disponível globalmente
    @current_user = current_user
  end
end
