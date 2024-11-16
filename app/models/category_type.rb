class CategoryType < ApplicationRecord
  has_many :transaction_categories
  validates :name, presence: true, uniqueness: true

  # Definir tipos fixos de categorias
  TYPES = [ "Receitas", "Investimentos", "Despesas Fixas", "Despesas Variáveis" ].freeze

  # Método de classe para criar os tipos de categoria padrão, caso não existam
  def self.create_default_types
    TYPES.each do |type_name|
      find_or_create_by(name: type_name)
    end
  end
end
