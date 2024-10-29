class FamilyGroup < ApplicationRecord
  has_many :group_members
  has_many :users, through: :group_members
  # has_many :transactions
  # has_many :budgets
end
