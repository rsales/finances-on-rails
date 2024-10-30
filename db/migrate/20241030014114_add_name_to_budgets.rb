class AddNameToBudgets < ActiveRecord::Migration[7.2]
  def change
    add_column :budgets, :name, :string
  end
end
