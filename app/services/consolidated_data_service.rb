class ConsolidatedDataService
  def initialize(family_group)
    @family_group = family_group
  end

  def call
    {
      total_budget: total_budget,
      total_transactions: total_transactions,
      categories_summary: categories_summary
    }
  end

  private

  def total_budget
    @family_group.budgets.sum(:value)
  end

  def total_transactions
    @family_group.transactions.sum(:value)
  end

  def categories_summary
    @family_group.transactions.group(:transaction_category).sum(:value)
  end
end
