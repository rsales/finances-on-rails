class Finances::TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family_group
  before_action :set_transaction, only: [ :show, :edit, :update, :destroy ]

  def index
    @transactions = @family_group.transactions
  end

  def show
  end

  def new
    @transaction = @family_group.transactions.build
  end

  def create
    @transaction = @family_group.transactions.build(transaction_params)

    if @transaction.save
      redirect_to finances_family_group_transactions_path(@family_group), notice: "Transa\u00E7\u00E3o criada com sucesso."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to finances_family_group_transaction_path(@family_group, @transaction), notice: "Transa\u00E7\u00E3o atualizada com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @transaction.destroy
    redirect_to finances_family_group_transactions_path(@family_group), notice: "Transa\u00E7\u00E3o exclu\u00EDda com sucesso."
  end

  private

  def set_family_group
    @family_group = current_user.family_groups.find(params[:family_group_id])
  end

  def set_transaction
    @transaction = @family_group.transactions.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:description, :amount, :transaction_category_id, :date)
  end
end