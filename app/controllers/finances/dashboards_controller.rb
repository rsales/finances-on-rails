class Finances::DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_and_authorize_family_group

  def show
  end

  private

  def set_and_authorize_family_group
    @family_group = current_user.family_groups.find_by(id: params[:family_group_id])
    unless @family_group
      redirect_to finances_home_path, alert: "Você não tem permissão para acessar este grupo familiar ou ele não existe."
    end
  end
end
