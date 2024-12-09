class Transaction < ApplicationRecord
  # Associations
  belongs_to :bank_account
  belongs_to :transaction_category
  belongs_to :family_group

  # Validations
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :month, presence: true, format: { with: /\A\d{4}-\d{2}\z/, message: "Formato deve ser YYYY-MM" }
  validates :subscription, inclusion: { in: [ true, false ] }
  # validates :number_of_installments, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  # validates :current_installment, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_nil: true

  # Callbacks
  after_create :create_future_installments, if: :subscription?

  # Personal Methods
  def subscription?
    subscription
  end

  private

  def create_future_installments
    return unless number_of_installments.present? && number_of_installments > 1
    return if current_installment > 1 # Evita recursão ao criar transações futuras

    (2..number_of_installments).each do |installment|
      future_transaction = self.dup
      future_transaction.month = (Date.parse(self.month + "-01") >> (installment - 1)).strftime("%Y-%m")
      future_transaction.current_installment = installment
      future_transaction.save(validate: false)
    end
  end
end
