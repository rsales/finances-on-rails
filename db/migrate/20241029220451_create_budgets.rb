class CreateBudgets < ActiveRecord::Migration[7.2]
  def change
    create_table :budgets do |t|
      t.decimal :value
      t.string :month
      t.boolean :subscription
      t.integer :number_of_installments
      t.integer :current_installment
      t.references :bank_account, null: false, foreign_key: true
      t.references :transaction_category, null: false, foreign_key: true
      t.references :family_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
