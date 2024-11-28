namespace :dev do
  desc "Config dev enviroment"
  task setup: :environment do
    # Criar Users
    puts "Create User..."
    # Users Family 1
    user1 = User.create(name: "Rafael Sales", email: "rafael.sales93@hotmail.com", password: "123456", password_confirmation: "123456")
    user2 = User.create(name: "Stephany Batista Ribeiro Sales", email: "stephany.batista96@hotmail.com", password: "123456", password_confirmation: "123456")
    # Users Family 2
    user3 = User.create(name: "Roberto Monteiro de Castro Filho", email: "roberto.mcf@hotmail.com", password: "123456", password_confirmation: "123456")
    user4 = User.create(name: "Beatriz D Bertolon ", email: "beatriz.dbf@hotmail.com", password: "123456", password_confirmation: "123456")
    puts "User created successfully..."

    # Criar grupos familiares
    puts "Create FamilyGroup..."
    family_group1 = FamilyGroup.create(name: "Família Sales")
    family_group2 = FamilyGroup.create(name: "Família Filho")
    family_group3 = FamilyGroup.create(name: "Sales Creations")
    puts "FamilyGroup created successfully..."

    # Associar membros do grupo familiar com papéis 'admin' ou 'editor'
    puts "Create GroupMember..."
    # Associar mebros da Family 1
    GroupMember.create(user: user1, family_group: family_group1, role: "admin")
    GroupMember.create(user: user2, family_group: family_group1, role: "admin")
    # Associar mebros da Family 2
    GroupMember.create(user: user3, family_group: family_group2, role: "admin")
    GroupMember.create(user: user4, family_group: family_group2, role: "admin")
    # Associar mebros da Grpupe 3
    GroupMember.create(user: user1, family_group: family_group3, role: "admin")
    puts "GroupMember created successfully..."

    # Criar contas bancárias
    puts "Create BankAccount..."
    bank_account1 = BankAccount.create(name: "Nubank Rafael", institution: "Nubank", user: user1)
    bank_account2 = BankAccount.create(name: "Inter Rafael", institution: "Inter", user: user1)
    bank_account3 = BankAccount.create(name: "Nubank Stephany", institution: "Nubank", user: user2)
    bank_account4 = BankAccount.create(name: "Generic Bank 1", institution: "Bank 1", user: user3)
    bank_account5 = BankAccount.create(name: "Generic Bank 2", institution: "Bank 2", user: user4)
    puts "BankAccount created successfully..."

    # Criar Orçamento
    puts "Create Budgets..."
    current_month = Time.current.strftime("%Y-%m")
    # Pega todas as categorias de transação do grupo
    transaction_categories = family_group1.transaction_categories
    transaction_categories.each do |category|
      # Cria um orçamento zerado se não existir para o mês atual
      unless family_group.budgets.exists?(month: current_month, transaction_category: category)
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

    # Criar transações
    puts "Create Transaction..."
    Transaction.create(name: "Salário Storyblok", value: 5000.00, month: "2024-10", subscription: false, number_of_installments: 0, current_installment: 0, bank_account: bank_account1, transaction_category: TransactionCategory.find_or_create_by(name: "Salário"), family_group: family_group1)
    Transaction.create(name: "Curso de RoR Udemy", value: 1500.00, month: "2024-10", subscription: true, number_of_installments: 12, current_installment: 1, bank_account: bank_account2, transaction_category: TransactionCategory.find_or_create_by(name: "Cursos"), family_group: family_group1)
    puts "Transaction created successfully..."
  end
end
