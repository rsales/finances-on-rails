# Criar usuários
puts "Create User..."
user1 = User.create(name: "Rafael Sales", email: "rafael.saes93@hotmail.com", password: "123456", password_confirmation: "123456")
user2 = User.create(name: "Stephany Batista Ribeiro Sales", email: "stephany.batista96@hotmail.com", password: "123456", password_confirmation: "123456")
puts "User created successfully..."

# Criar tipos de categoria
puts "Create CategoryType..."
CategoryType.create_default_types

revenues_category = CategoryType.find_by(name: 'Revenues')
investment_category = CategoryType.find_by(name: 'Investments')
fixed_expenses_category = CategoryType.find_by(name: 'Fixed Expenses')
variable_expenses_category = CategoryType.find_by(name: 'Variable Expenses')
puts "CategoryType created successfully..."

# Criar grupos familiares
puts "Create FamilyGroup..."
family_group1 = FamilyGroup.create(name: 'Família Sales')
puts "FamilyGroup created successfully..."

# Associar membros do grupo familiar com papéis 'admin' ou 'editor'
puts "Create GroupMember..."
GroupMember.create(user: user1, family_group: family_group1, role: 'admin')
GroupMember.create(user: user2, family_group: family_group1, role: 'editor')
puts "GroupMember created successfully..."

# Criar contas bancárias
puts "Create BankAccount..."
bank_account1 = BankAccount.create(name: 'Nubank Rafael', institution: 'Nubank', user: user1)
bank_account2 = BankAccount.create(name: 'Inter Rafael', institution: 'Inter', user: user1)
bank_account3 = BankAccount.create(name: 'Nubank Stephany', institution: 'Inter', user: user2)
puts "BankAccount created successfully..."

# Criar categorias de transação
puts "Create TransactionCategory..."
transaction_category1 = TransactionCategory.create(name: 'Salário', category_type: revenues_category, family_group: family_group1)
transaction_category2 = TransactionCategory.create(name: 'Freelas', category_type: revenues_category, family_group: family_group1)
transaction_category3 = TransactionCategory.create(name: 'Investimentos / Poupar', category_type: investment_category, family_group: family_group1)
transaction_category4 = TransactionCategory.create(name: 'Cursos e Livros', category_type: investment_category, family_group: family_group1)
transaction_category5 = TransactionCategory.create(name: 'Estudos', category_type: investment_category, family_group: family_group1)
transaction_category6 = TransactionCategory.create(name: 'Alimentação', category_type: fixed_expenses_category, family_group: family_group1)
transaction_category7 = TransactionCategory.create(name: 'Serviços de Streaming', category_type: fixed_expenses_category, family_group: family_group1)
transaction_category8 = TransactionCategory.create(name: 'Seguro de Vida', category_type: fixed_expenses_category, family_group: family_group1)
transaction_category9 = TransactionCategory.create(name: 'Plano de Telefone', category_type: fixed_expenses_category, family_group: family_group1)
transaction_category10 = TransactionCategory.create(name: 'Outros', category_type: fixed_expenses_category, family_group: family_group1)
transaction_category11 = TransactionCategory.create(name: 'Lanches', category_type: variable_expenses_category, family_group: family_group1)
transaction_category12 = TransactionCategory.create(name: 'Animais de estimação', category_type: variable_expenses_category, family_group: family_group1)
transaction_category13 = TransactionCategory.create(name: 'Beleza e vestuário', category_type: variable_expenses_category, family_group: family_group1)
transaction_category14 = TransactionCategory.create(name: 'Cartão de crédito', category_type: variable_expenses_category, family_group: family_group1)
transaction_category15 = TransactionCategory.create(name: 'Lazer', category_type: variable_expenses_category, family_group: family_group1)
transaction_category16 = TransactionCategory.create(name: 'Gastos com saúde', category_type: variable_expenses_category, family_group: family_group1)
transaction_category17 = TransactionCategory.create(name: 'Transporte', category_type: variable_expenses_category, family_group: family_group1)
transaction_category18 = TransactionCategory.create(name: 'Transporte', category_type: variable_expenses_category, family_group: family_group1)
transaction_category19 = TransactionCategory.create(name: 'Outros', category_type: variable_expenses_category, family_group: family_group1)
puts "TransactionCategory created successfully..."

# Criar transações
Transaction.create(value: 5000.00, month: '2024-10', subscription: false, number_of_installments: 0, current_installment: 0, bank_account: bank_account1, transaction_category: transaction_category1, family_group: family_group1)
Transaction.create(value: 1500.00, month: '2024-10', subscription: true, number_of_installments: 12, current_installment: 1, bank_account: bank_account2, transaction_category: transaction_category2, family_group: family_group2)

# Criar orçamentos
Budget.create(value: 2000.00, month: '2024-10', subscription: true, number_of_installments: 6, current_installment: 3, bank_account: bank_account1, transaction_category: transaction_category1, family_group: family_group1)
Budget.create(value: 800.00, month: '2024-10', subscription: false, number_of_installments: 0, current_installment: 0, bank_account: bank_account2, transaction_category: transaction_category2, family_group: family_group2)
