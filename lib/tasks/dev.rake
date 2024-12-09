namespace :dev do
  desc "Config dev enviroment"
  task setup: :environment do
    puts "Create User..."
    user1 = User.create(name: "Rafael Sales", email: "rafael.sales93@hotmail.com", password: "123456", password_confirmation: "123456")
    user2 = User.create(name: "Stephany Batista Ribeiro Sales", email: "stephany.batista96@hotmail.com", password: "123456", password_confirmation: "123456")
    user3 = User.create(name: "Roberto Monteiro de Castro Filho", email: "roberto.mcf@hotmail.com", password: "123456", password_confirmation: "123456")
    user4 = User.create(name: "Beatriz D Bertolon ", email: "beatriz.dbf@hotmail.com", password: "123456", password_confirmation: "123456")
    user5 = User.create(name: "Rafael Sales", email: "rafael.sales1993@gmail.com", password: "123456", password_confirmation: "123456")
    puts "User created successfully..."

    puts "Create FamilyGroup..."
    family_group1 = FamilyGroup.create(name: "Família Sales")
    family_group2 = FamilyGroup.create(name: "Família Filho")
    family_group3 = FamilyGroup.create(name: "Sales Creations")
    puts "FamilyGroup created successfully..."

    puts "Create GroupMember..."
    GroupMember.create(user: user1, family_group: family_group1, role: "Owner")
    GroupMember.create(user: user2, family_group: family_group1, role: "Admin")
    GroupMember.create(user: user3, family_group: family_group2, role: "Owner")
    GroupMember.create(user: user4, family_group: family_group2, role: "Admin")
    GroupMember.create(user: user1, family_group: family_group3, role: "Owner")
    puts "GroupMember created successfully..."

    puts "Create BankAccount..."
    bank_account1 = BankAccount.create(name: "Nubank Rafael", institution: "Nubank", user: user1)
    bank_account2 = BankAccount.create(name: "Inter Rafael", institution: "Inter", user: user1)
    bank_account3 = BankAccount.create(name: "Nubank Stephany", institution: "Nubank", user: user2)
    bank_account4 = BankAccount.create(name: "Generic Bank 1", institution: "Bank 1", user: user3)
    bank_account5 = BankAccount.create(name: "Generic Bank 2", institution: "Bank 2", user: user4)
    puts "BankAccount created successfully..."

    puts "Create Budgets..."
    current_month = Time.current.strftime("%Y-%m")

    transaction_categories = family_group1.transaction_categories
    transaction_categories.each do |category|
      unless family_group1.budgets.exists?(month: current_month, transaction_category: category)
        Budget.create!(
          value: 0.0,
          month: current_month,
          transaction_category: category,
          family_group: family_group1
        )
      end
    end
    puts "Budgets criados para o mês #{current_month}."
    puts "Budgets created successfully..."

    puts "Creating mock transactions for the year 2024..."
    # Categorias
    salario_category = TransactionCategory.find_or_create_by(name: "Salário", family_group: family_group1)
    cursos_category = TransactionCategory.find_or_create_by(name: "Cursos", family_group: family_group1)
    aluguel_category = TransactionCategory.find_or_create_by(name: "Casa", family_group: family_group1)
    supermercado_category = TransactionCategory.find_or_create_by(name: "Alimentação", family_group: family_group1)
    investimentos_category = TransactionCategory.find_or_create_by(name: "Investimentos/Poupar", family_group: family_group1)

    # Mock de transações por mês
    (1..12).each do |month|
      formatted_month = format("%04d-%02d", 2024, month) # Formata como "2024-01", "2024-02", etc.

      # Receita
      Transaction.create!(
        name: "Salário Mensal",
        value: 5000.00 + rand(-200..200), # Valor flutua entre 4800 e 5200
        month: formatted_month,
        subscription: false,
        number_of_installments: 0,
        current_installment: 0,
        bank_account: bank_account1,
        transaction_category: salario_category,
        family_group: family_group1
      )

      # Gastos Fixos
      Transaction.create!(
        name: "Aluguel",
        value: 1500.00,
        month: formatted_month,
        subscription: false,
        number_of_installments: 0,
        current_installment: 0,
        bank_account: bank_account1,
        transaction_category: aluguel_category,
        family_group: family_group1
      )

      # Gastos Variáveis
      Transaction.create!(
        name: "Compras no Supermercado",
        value: 800.00 + rand(-100..100), # Valor flutua entre 700 e 900
        month: formatted_month,
        subscription: false,
        number_of_installments: 0,
        current_installment: 0,
        bank_account: bank_account1,
        transaction_category: supermercado_category,
        family_group: family_group1
      )

      # Investimentos
      Transaction.create!(
        name: "Aporte Mensal em Investimentos",
        value: 1000.00 + rand(-50..50), # Valor flutua entre 950 e 1050
        month: formatted_month,
        subscription: false,
        number_of_installments: 0,
        current_installment: 0,
        bank_account: bank_account2,
        transaction_category: investimentos_category,
        family_group: family_group1
      )

      # Cursos (Gasto Variável com Parcelamento)
      if month == 1 # Apenas iniciar um curso em janeiro
        Transaction.create!(
          name: "Curso de Ruby on Rails",
          value: 1200.00,
          month: formatted_month,
          subscription: true,
          number_of_installments: 12,
          current_installment: 1,
          bank_account: bank_account2,
          transaction_category: cursos_category,
          family_group: family_group1
        )
      elsif month <= 12 # Parcelas subsequentes
        Transaction.create!(
          name: "Curso de Ruby on Rails (Parcela #{month})",
          value: 100.00, # Valor da parcela
          month: formatted_month,
          subscription: true,
          number_of_installments: 12,
          current_installment: month,
          bank_account: bank_account2,
          transaction_category: cursos_category,
          family_group: family_group1
        )
      end
    end

    puts "Transactions for 2024 created successfully!"
  end
end


############################################################################################################
# Rails C - Mock Transaction simulating a subscription
############################################################################################################

# # Encontre ou crie os objetos associados necessários
# family_group = FamilyGroup.find_or_create_by(name: "Família Sales")
# bank_account = BankAccount.find_or_create_by(name: "Nubank Rafael") do |account|
#   account.family_group = family_group
# end
# transaction_category = TransactionCategory.find_or_create_by(name: "Casa", family_group: family_group)

# # Crie a transação inicial
# transaction = Transaction.create(
#   name: "Compra de Exemplo",
#   value: 100.0,
#   month: "2024-11",
#   subscription: true,
#   number_of_installments: 2,
#   current_installment: 1,
#   bank_account: bank_account,
#   transaction_category: transaction_category,
#   family_group: family_group
# )

# # Verifique se a transação foi criada corretamente
# puts transaction.errors.full_messages unless transaction.persisted?

# # Verifique se as transações futuras foram criadas
# future_transactions = Transaction.where("month > ?", transaction.month)
# puts future_transactions.map { |t| "#{t.name} - #{t.month} - Parcela #{t.current_installment} de #{t.number_of_installments}" }



############################################################################################################
# Rails C - Mock Transaction simulating a subscription destroy
############################################################################################################

# # Encontre a transação inicial
# transaction = Transaction.find_by(name: "Compra de Exemplo", month: "2024-11")

# if transaction
#   # Verifique se a transação foi encontrada
#   puts "Transação encontrada: #{transaction.name} - #{transaction.month} - Parcela #{transaction.current_installment} de #{transaction.number_of_installments}"

#   # Simule a ação destroy para remover todas as parcelas
#   transaction.destroy

#   # Verifique se todas as transações foram removidas
#   remaining_transactions = Transaction.where(name: "Compra de Exemplo", transaction_category: transaction.transaction_category, bank_account: transaction.bank_account)
#   puts "Transações restantes: #{remaining_transactions.map { |t| "#{t.name} - #{t.month} - Parcela #{t.current_installment} de #{t.number_of_installments}" }}"
# else
#   puts "Transação não encontrada."
# end
