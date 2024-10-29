class FamilyGroupsController < ApplicationController
  before_action :set_family_group, only: %i[ show edit update destroy ]

  # GET /family_groups or /family_groups.json
  def index
    @family_groups = FamilyGroup.all
  end

  # GET /family_groups/1 or /family_groups/1.json
  def show
  end

  # GET /family_groups/new
  def new
    @family_group = FamilyGroup.new
  end

  # GET /family_groups/1/edit
  def edit
  end

  # POST /family_groups or /family_groups.json
  def create
    @family_group = FamilyGroup.new(family_group_params)

    respond_to do |format|
      if @family_group.save
        format.html { redirect_to @family_group, notice: "Family group was successfully created." }
        format.json { render :show, status: :created, location: @family_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @family_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /family_groups/1 or /family_groups/1.json
  def update
    respond_to do |format|
      if @family_group.update(family_group_params)
        format.html { redirect_to @family_group, notice: "Family group was successfully updated." }
        format.json { render :show, status: :ok, location: @family_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @family_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /family_groups/1 or /family_groups/1.json
  def destroy
    @family_group.destroy!

    respond_to do |format|
      format.html { redirect_to family_groups_path, status: :see_other, notice: "Family group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family_group
      @family_group = FamilyGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def family_group_params
      params.require(:family_group).permit(:name)
    end
end
