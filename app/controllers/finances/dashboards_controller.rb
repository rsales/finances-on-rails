class Finances::DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @family_group = FamilyGroup.find(params[:family_group_id])

  rescue ActiveRecord::RecordNotFound
    redirect_to finances_path, alert: "Grupo de Família não encontrado."
  end
end
