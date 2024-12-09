class GroupMember < ApplicationRecord
  belongs_to :user
  belongs_to :family_group

  accepts_nested_attributes_for :user

  # Validations
  validates :role, presence: true, inclusion: { in: %w[Owner Admin Editor] }
end
