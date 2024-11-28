class Budget < ApplicationRecord
  # Associações
  belongs_to :transaction_category
  belongs_to :family_group

  # Validações
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :month, presence: true, format: { with: /\A\d{4}-\d{2}\z/, message: "Formato deve ser YYYY-MM" }
  validates :transaction_category, presence: true
  validates :family_group, presence: true

  # Validação de unicidade para garantir que não existam orçamentos duplicados para o mesmo family_group, transaction_category e month
  validates :transaction_category, uniqueness: { scope: [ :family_group, :month ], message: "Já existe um orçamento para essa categoria e mês" }
end
