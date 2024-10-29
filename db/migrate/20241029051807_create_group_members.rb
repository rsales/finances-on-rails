class CreateGroupMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :group_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :family_group, null: false, foreign_key: true
      t.string :role
      t.datetime :joined_at

      t.timestamps
    end
  end
end
