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
    puts "FamilyGroup created successfully..."

    # Associar membros do grupo familiar com papéis 'admin' ou 'editor'
    puts "Create GroupMember..."
    # Associar mebros da Family 1
    GroupMember.create(user: user1, family_group: family_group1, role: "admin")
    GroupMember.create(user: user2, family_group: family_group1, role: "admin")
    # Associar mebros da Family 2
    GroupMember.create(user: user3, family_group: family_group1, role: "admin")
    GroupMember.create(user: user4, family_group: family_group1, role: "admin")
    puts "GroupMember created successfully..."

    # Criar contas bancárias
    puts "Create BankAccount..."
    bank_account1 = BankAccount.create(name: "Nubank Rafael", institution: "Nubank", user: user1)
    bank_account2 = BankAccount.create(name: "Inter Rafael", institution: "Inter", user: user1)
    bank_account3 = BankAccount.create(name: "Nubank Stephany", institution: "Nubank", user: user2)
    bank_account4 = BankAccount.create(name: "Generic Bank 1", institution: "Bank 1", user: user3)
    bank_account5 = BankAccount.create(name: "Generic Bank 2", institution: "Bank 2", user: user4)
    puts "BankAccount created successfully..."

    # Criar transações
    puts "Create Transaction..."
    Transaction.create(name: "Salário Storyblok", value: 5000.00, month: "2024-10", subscription: false, number_of_installments: 0, current_installment: 0, bank_account: bank_account1, transaction_category: TransactionCategory.find_or_create_by(name: "Salário"), family_group: family_group1)
    Transaction.create(name: "Curso de RoR Udemy", value: 1500.00, month: "2024-10", subscription: true, number_of_installments: 12, current_installment: 1, bank_account: bank_account2, transaction_category: TransactionCategory.find_or_create_by(name: "Cursos"), family_group: family_group1)
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
