class CreateMonthlyBudgetsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Obtem o mês atual no formato YYYY-MM
    current_month = Time.now.strftime("%Y-%m")

    # Itera por todos os grupos familiares
    FamilyGroup.find_each do |family_group|
      # Para cada grupo familiar, obtém todas as categorias de transação
      family_group.transaction_categories.find_each do |category|
        # Verifica se já existe um orçamento para o mês e categoria
        next if Budget.exists?(family_group: family_group, transaction_category: category, month: current_month)

        # Cria o orçamento com valor zerado
        Budget.create!(
          family_group: family_group,
          transaction_category: category,
          value: 0.0, # Valor inicial zerado
          month: current_month
        )
      end
    end
  end
end
