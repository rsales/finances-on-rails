class Users::ConfigurationsController < ApplicationController
  before_action :set_user

  def edit_profile
    # Lógica para editar o perfil do Devise
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
