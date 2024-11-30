class Finances::ConsolidatedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family_group

  def index
    @consolidated_data = ConsolidatedDataService.new(@family_group).call
  end

  private

  def set_family_group
    @family_group = current_user.family_groups.find(params[:family_group_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to finances_home_path, alert: "Grupo familiar não encontrado."
  end
end
