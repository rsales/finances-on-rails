json.extract! transaction, :id, :value, :month, :subscription, :number_of_installments, :current_installment, :bank_account_id, :transaction_category_id, :family_group_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
