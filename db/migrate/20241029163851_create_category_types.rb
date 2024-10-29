class CreateCategoryTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :category_types do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :category_types, :name, unique: true
  end
end
