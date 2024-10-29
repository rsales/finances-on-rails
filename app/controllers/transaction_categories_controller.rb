class TransactionCategoriesController < ApplicationController
  before_action :set_transaction_category, only: %i[ show edit update destroy ]

  # GET /transaction_categories or /transaction_categories.json
  def index
    @transaction_categories = TransactionCategory.all
  end

  # GET /transaction_categories/1 or /transaction_categories/1.json
  def show
  end

  # GET /transaction_categories/new
  def new
    @transaction_category = TransactionCategory.new
  end

  # GET /transaction_categories/1/edit
  def edit
  end

  # POST /transaction_categories or /transaction_categories.json
  def create
    @transaction_category = TransactionCategory.new(transaction_category_params)

    respond_to do |format|
      if @transaction_category.save
        format.html { redirect_to @transaction_category, notice: "Transaction category was successfully created." }
        format.json { render :show, status: :created, location: @transaction_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaction_categories/1 or /transaction_categories/1.json
  def update
    respond_to do |format|
      if @transaction_category.update(transaction_category_params)
        format.html { redirect_to @transaction_category, notice: "Transaction category was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_categories/1 or /transaction_categories/1.json
  def destroy
    @transaction_category.destroy!

    respond_to do |format|
      format.html { redirect_to transaction_categories_path, status: :see_other, notice: "Transaction category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_category
      @transaction_category = TransactionCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_category_params
      params.require(:transaction_category).permit(:name, :category_type_id, :family_group_id)
    end
end
