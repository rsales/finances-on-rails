class Transaction < ApplicationRecord
  # Associações
  belongs_to :bank_account
  belongs_to :transaction_category
  belongs_to :family_group

  # Validações
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :month, presence: true, format: { with: /\A\d{4}-\d{2}\z/, message: "Formato deve ser YYYY-MM" }
  validates :subscription, inclusion: { in: [ true, false ] }
  # validates :number_of_installments, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  # validates :current_installment, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_nil: true

  # Métodos personalizados
  def subscription?
    subscription
  end

  def next_installment
    if subscription? && current_installment < number_of_installments
      self.current_installment += 1
      save
    end
  end
end
