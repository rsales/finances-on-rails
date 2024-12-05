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
        # Comparando diretamente o mês (extraindo o número do mês da string "YYYY-MM")
        t.transaction_category == category && t.month.split("-")[1].to_i == month
      end

      [ month, relevant_transactions.sum(&:value) ]
    end.to_h

    total = monthly_values.values.compact.sum
    percentage = calculate_percentage(total, transactions)

    monthly_values.merge(total: total, percentage: percentage)
  end


  # Calcular a porcentagem do RL
  def calculate_percentage(category_total, transactions)
    total_per_month = (1..12).map do |month|
      transactions.select { |t| t.month.to_i == month }.sum(&:value)
    end
    return 0 if total_per_month.sum == 0
    (category_total.to_f / total_per_month.sum) * 100
  end
end
