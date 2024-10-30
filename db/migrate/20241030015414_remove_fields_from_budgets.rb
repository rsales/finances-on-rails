class RemoveFieldsFromBudgets < ActiveRecord::Migration[7.2]
  def change
    remove_column :budgets, :name, :string
    remove_column :budgets, :subscription, :boolean
    remove_column :budgets, :number_of_installments, :integer
    remove_column :budgets, :current_installment, :integer
    remove_reference :budgets, :bank_account, null: false, foreign_key: true
  end
end
