class FamilyGroup < ApplicationRecord
  has_many :group_members
  has_many :users, through: :group_members
  has_many :transaction_categories
  has_many :transactions
  has_many :budgets, dependent: :destroy

  accepts_nested_attributes_for :group_members, allow_destroy: true

  after_create :create_default_transaction_category

  def create_default_transaction_category
    # Rceitas
    TransactionCategory.create(name: "Salário", category_type: CategoryType.find_or_create_by(name: "Receitas"), family_group_id: self.id) # 1
    TransactionCategory.create(name: "Aluguel", category_type: CategoryType.find_or_create_by(name: "Receitas"), family_group_id: self.id) # 2
    TransactionCategory.create(name: "Férias", category_type: CategoryType.find_or_create_by(name: "Receitas"), family_group_id: self.id) # 3
    TransactionCategory.create(name: "13º Salário", category_type: CategoryType.find_or_create_by(name: "Receitas"), family_group_id: self.id) # 4
    TransactionCategory.create(name: "Reembolsos", category_type: CategoryType.find_or_create_by(name: "Receitas"), family_group_id: self.id) # 5
    TransactionCategory.create(name: "Outros", category_type: CategoryType.find_or_create_by(name: "Receitas"), family_group_id: self.id) # 6
    # Investimentos
    TransactionCategory.create(name: "Investimentos/Poupar", category_type: CategoryType.find_or_create_by(name: "Investimentos"), family_group_id: self.id) # 7
    TransactionCategory.create(name: "Cursos", category_type: CategoryType.find_or_create_by(name: "Investimentos"), family_group_id: self.id) # 8
    TransactionCategory.create(name: "Livros", category_type: CategoryType.find_or_create_by(name: "Investimentos"), family_group_id: self.id) # 9
    TransactionCategory.create(name: "Estudos", category_type: CategoryType.find_or_create_by(name: "Investimentos"), family_group_id: self.id) # 10
    TransactionCategory.create(name: "Outros", category_type: CategoryType.find_or_create_by(name: "Investimentos"), family_group_id: self.id) # 11
    # Gastos Fixos
    TransactionCategory.create(name: "Alimentação", category_type: CategoryType.find_or_create_by(name: "Gastos Fixos"), family_group_id: self.id) # 12
    TransactionCategory.create(name: "Serviços de Streaming", category_type: CategoryType.find_or_create_by(name: "Gastos Fixos"), family_group_id: self.id) # 13
    TransactionCategory.create(name: "Seguro de Vida", category_type: CategoryType.find_or_create_by(name: "Gastos Fixos"), family_group_id: self.id) # 14
    TransactionCategory.create(name: "Seguro do Carro", category_type: CategoryType.find_or_create_by(name: "Gastos Fixos"), family_group_id: self.id) # 15
    TransactionCategory.create(name: "Plano de Saúde", category_type: CategoryType.find_or_create_by(name: "Gastos Fixos"), family_group_id: self.id) # 16
    TransactionCategory.create(name: "Celular", category_type: CategoryType.find_or_create_by(name: "Gastos Fixos"), family_group_id: self.id) # 17
    # Gastos Variáveis
    TransactionCategory.create(name: "Lanches", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 18
    TransactionCategory.create(name: "Lazer", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 19
    TransactionCategory.create(name: "Animais de Estimação", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 20
    TransactionCategory.create(name: "Beleza e Vestuário", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 21
    TransactionCategory.create(name: "Cartão de Crédito", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 22
    TransactionCategory.create(name: "Saúde", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 23
    TransactionCategory.create(name: "Carro", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 24
    TransactionCategory.create(name: "Transporte", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 25
    TransactionCategory.create(name: "Casa", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 26
    TransactionCategory.create(name: "Outros", category_type: CategoryType.find_or_create_by(name: "Gastos Variáveis"), family_group_id: self.id) # 27
  end
end
