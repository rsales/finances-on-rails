class AddNameToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :name, :string
  end
end
