class FamilyGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @family_groups = current_user.family_groups
  end

  def new
    @family_group = FamilyGroup.new
    @family_group.group_members.build(user: current_user, role: "Owner") # Adiciona o usuário atual ao grupo familiar com a função "Owner"
    respond_to do |format|
      format.turbo_stream { render :new }
      format.html { render :new, layout: false }
    end
  end

  def create
    @family_group = FamilyGroup.new(family_group_params)
    if @family_group.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.before("add-family-group-button", FamilyGroupCardComponent.new(family_group: @family_group)),
            turbo_stream.remove("modal")
          ]
        end
        format.html { redirect_to family_groups_path, notice: "Grupo Financeiro criado com sucesso." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :new }
        format.html { render :new, layout: false }
      end
    end
  end

  private

  def family_group_params
    params.require(:family_group).permit(:name, group_members_attributes: [ :id, :user_id, :role, :_destroy, user_attributes: [ :name, :email ] ])
  end
end
