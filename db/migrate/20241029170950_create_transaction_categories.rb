class CreateTransactionCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :transaction_categories do |t|
      t.string :name
      t.references :category_type, null: false, foreign_key: true
      t.references :family_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
