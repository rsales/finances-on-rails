class Finances::HomeController < ApplicationController
  before_action :authenticate_user!  # Garante que o usuário esteja autenticado

  def index
    @family_groups = current_user.family_groups
    @current_user = current_user
  end
end
