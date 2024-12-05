class ConsolidatedDataService
  def initialize(family_group, year)
    @family_group = family_group
    @year = year
  end

  def call
    # Carregar as categorias de transação associadas ao family_group (direta ou indiretamente)
    transaction_categories = TransactionCategory
      .where(id: @family_group.transactions.select(:transaction_category_id).distinct)
      .or(TransactionCategory.where(family_group_id: @family_group.id)) # Caso exista uma relação direta
      .includes(:category_type)

    # Carregar as transações dentro do ano especificado, incluindo as categorias
    transactions = @family_group.transactions
      .includes(:transaction_category)
      .where("month LIKE ?", "#{@year}-%") # Filtra as transações do ano

    # Agrupar as transações por category_type e transaction_category
    grouped_data = transaction_categories.group_by { |cat| cat.category_type.name }.transform_values do |categories|
      categories.each_with_object({}) do |category, result|
        result[category.name] = calculate_monthly_data(category, transactions)
      end
    end

    # Retornar os dados organizados
    grouped_data
  end

  private

  # Método para calcular os valores por mês, para cada categoria
  def calculate_monthly_data(category, transactions)
    monthly_values = (1..12).map do |month|
      relevant_transactions = transactions.select do |t|
        # Usando Date para garantir a extração correta do mês
        t.transaction_category == category && Date.strptime(t.month, "%Y-%m").month == month
      end

      [ month, relevant_transactions.sum(&:value) ]
    end.to_h

    total = monthly_values.values.sum
    percentage = calculate_percentage(total, transactions)

    monthly_values.merge(total: total, percentage: percentage)
  end

  # Calcular a porcentagem do RL
  def calculate_percentage(category_total, transactions)
    total_transactions = transactions.sum(&:value)
    return 0 if total_transactions == 0

    (category_total.to_f / total_transactions) * 100
  end
end
