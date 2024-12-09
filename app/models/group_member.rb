class GroupMember < ApplicationRecord
  belongs_to :user
  belongs_to :family_group

  # Validations
  validates :role, presence: true, inclusion: { in: %w[Owner Admin Editor] }
end
