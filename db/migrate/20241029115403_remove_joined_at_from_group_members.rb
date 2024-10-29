class RemoveJoinedAtFromGroupMembers < ActiveRecord::Migration[7.2]
  def change
    remove_column :group_members, :joined_at, :datetime
  end
end
