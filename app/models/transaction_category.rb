class TransactionCategory < ApplicationRecord
  belongs_to :category_type
  belongs_to :family_group

  validates :name, presence: true
  validates :category_type, presence: true
end
