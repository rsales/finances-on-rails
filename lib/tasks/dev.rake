namespace :dev do
  desc "Config dev enviroment"
  task setup: :environment do
    # Criar Users
    puts "Create User..."
    user1 = User.create(name: "Rafael Sales", email: "rafael.sales93@hotmail.com", password: "123456", password_confirmation: "123456")
    user2 = User.create(name: "Stephany Batista Ribeiro Sales", email: "stephany.batista96@hotmail.com", password: "123456", password_confirmation: "123456")
    puts "User created successfully..."

    # Criar variáveis de CategoryType
    puts "Create variables for CategoryType..."
    revenues_category = CategoryType.find_by(name: "Revenues")
    investment_category = CategoryType.find_by(name: "Investments")
    fixed_expenses_category = CategoryType.find_by(name: "Fixed Expenses")
    variable_expenses_category = CategoryType.find_by(name: "Variable Expenses")
    puts "Variabels CategoryType created successfully..."

    # Criar grupos familiares
    puts "Create FamilyGroup..."
    family_group1 = FamilyGroup.create(name: "Fam\u00EDlia Sales")
    puts "FamilyGroup created successfully..."

    # Associar membros do grupo familiar com papéis 'admin' ou 'editor'
    puts "Create GroupMember..."
    GroupMember.create(user: user1, family_group: family_group1, role: "admin")
    GroupMember.create(user: user2, family_group: family_group1, role: "editor")
    puts "GroupMember created successfully..."

    # Criar contas bancárias
    puts "Create BankAccount..."
    bank_account1 = BankAccount.create(name: "Nubank Rafael", institution: "Nubank", user: user1)
    bank_account2 = BankAccount.create(name: "Inter Rafael", institution: "Inter", user: user1)
    bank_account3 = BankAccount.create(name: "Nubank Stephany", institution: "Nubank", user: user2)
    puts "BankAccount created successfully..."

    # Criar categorias de transação
    puts "Create TransactionCategory..."
    transaction_category1 = TransactionCategory.create(name: "Sal\u00E1rio", category_type: revenues_category, family_group: family_group1)
    transaction_category2 = TransactionCategory.create(name: "Freelas", category_type: revenues_category, family_group: family_group1)
    transaction_category3 = TransactionCategory.create(name: "Investimentos / Poupar", category_type: investment_category, family_group: family_group1)
    transaction_category4 = TransactionCategory.create(name: "Cursos e Livros", category_type: investment_category, family_group: family_group1)
    transaction_category5 = TransactionCategory.create(name: "Estudos", category_type: investment_category, family_group: family_group1)
    transaction_category6 = TransactionCategory.create(name: "Alimenta\u00E7\u00E3o", category_type: fixed_expenses_category, family_group: family_group1)
    transaction_category7 = TransactionCategory.create(name: "Servi\u00E7os de Streaming", category_type: fixed_expenses_category, family_group: family_group1)
    transaction_category8 = TransactionCategory.create(name: "Seguro de Vida", category_type: fixed_expenses_category, family_group: family_group1)
    transaction_category9 = TransactionCategory.create(name: "Plano de Telefone", category_type: fixed_expenses_category, family_group: family_group1)
    transaction_category10 = TransactionCategory.create(name: "Outros", category_type: fixed_expenses_category, family_group: family_group1)
    transaction_category11 = TransactionCategory.create(name: "Lanches", category_type: variable_expenses_category, family_group: family_group1)
    transaction_category12 = TransactionCategory.create(name: "Animais de estima\u00E7\u00E3o", category_type: variable_expenses_category, family_group: family_group1)
    transaction_category13 = TransactionCategory.create(name: "Beleza e vestu\u00E1rio", category_type: variable_expenses_category, family_group: family_group1)
    transaction_category14 = TransactionCategory.create(name: "Cart\u00E3o de cr\u00E9dito", category_type: variable_expenses_category, family_group: family_group1)
    transaction_category15 = TransactionCategory.create(name: "Lazer", category_type: variable_expenses_category, family_group: family_group1)
    transaction_category16 = TransactionCategory.create(name: "Gastos com sa\u00FAde", category_type: variable_expenses_category, family_group: family_group1)
    transaction_category17 = TransactionCategory.create(name: "Transporte", category_type: variable_expenses_category, family_group: family_group1)
    transaction_category18 = TransactionCategory.create(name: "Transporte", category_type: variable_expenses_category, family_group: family_group1)
    transaction_category19 = TransactionCategory.create(name: "Outros", category_type: variable_expenses_category, family_group: family_group1)
    puts "TransactionCategory created successfully..."

    # Criar transações
    puts "Create Transaction..."
    Transaction.create(name: "Salário Storyblok", value: 5000.00, month: "2024-10", subscription: false, number_of_installments: 0, current_installment: 0, bank_account: bank_account1, transaction_category: transaction_category1, family_group: family_group1)
    Transaction.create(name: "Curso de RoR Udemy", value: 1500.00, month: "2024-10", subscription: true, number_of_installments: 12, current_installment: 1, bank_account: bank_account2, transaction_category: transaction_category4, family_group: family_group1)
    puts "Transaction created successfully..."

    # puts "Create Lists..."
    # 5.times do |i|
    #   List.create!(
    #     name: Faker::Food.dish,
    #     purshase_data: Faker::Date.in_date_period,
    #     completed: Faker::Boolean.boolean,
    #   )
    # end
    # puts "Lists created successfully..."

    # puts "Create Procuts..."
    # List.all.each do |list|
    #   Random.rand(5).times do |i|
    #     product = Product.create!(
    #       name: Faker::Food.ingredient,
    #       quantity: Faker::Number.number(digits: 1),
    #       purchased: Faker::Boolean.boolean,
    #       price: Faker::Commerce.price,
    #       list_id: Faker::Number.between(from: 1, to: 5),
    #     )
    #     # Include total price using product 'price' and 'quantity'
    #     product.total_price = product.price * product.quantity
    #     # Include product in 'list.product' and save Product
    #     list.products << product
    #     product.save!
    #   end

    #   # Include value 'list.total_products'based all products in list
    #   list.total_products = list.products.length
    #   # Map and sum value all products in List
    #   product_total_price = list.products.map { |p| p.price }.sum
    #   list.total_price = product_total_price

    #   # Save all update List
    #   list.save!
    # end
    # puts "Products created successfully..."
  end
end
