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
      @family_group.group_members.create(user: current_user, role: "Owner") # Inclui automaticamente o usuário no grupo familiar com a função "Owner"
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

  def add_user
    @family_group = FamilyGroup.find(params[:id])
    user = User.find_by(email: params[:email])

    if user
      @family_group.users << user unless @family_group.users.include?(user)
      notice = "Usuário adicionado ao grupo familiar com sucesso."
    else
      # Enviar email de convite
      UserMailer.invite_user(params[:email], @family_group).deliver_now
      notice = "Convite enviado para o email fornecido."
    end

    respond_to do |format|
      format.turbo_stream { render :update_users }
      format.html { redirect_to new_family_group_path(@family_group), notice: notice }
    end
  end

  private

  def family_group_params
    params.require(:family_group).permit(:name, user_ids: [])
  end
end
