require "test_helper"

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @budget = budgets(:one)
  end

  test "should get index" do
    get budgets_url
    assert_response :success
  end

  test "should get new" do
    get new_budget_url
    assert_response :success
  end

  test "should create budget" do
    assert_difference("Budget.count") do
      post budgets_url, params: { budget: { bank_account_id: @budget.bank_account_id, current_installment: @budget.current_installment, family_group_id: @budget.family_group_id, month: @budget.month, number_of_installments: @budget.number_of_installments, subscription: @budget.subscription, transaction_category_id: @budget.transaction_category_id, value: @budget.value } }
    end

    assert_redirected_to budget_url(Budget.last)
  end

  test "should show budget" do
    get budget_url(@budget)
    assert_response :success
  end

  test "should get edit" do
    get edit_budget_url(@budget)
    assert_response :success
  end

  test "should update budget" do
    patch budget_url(@budget), params: { budget: { bank_account_id: @budget.bank_account_id, current_installment: @budget.current_installment, family_group_id: @budget.family_group_id, month: @budget.month, number_of_installments: @budget.number_of_installments, subscription: @budget.subscription, transaction_category_id: @budget.transaction_category_id, value: @budget.value } }
    assert_redirected_to budget_url(@budget)
  end

  test "should destroy budget" do
    assert_difference("Budget.count", -1) do
      delete budget_url(@budget)
    end

    assert_redirected_to budgets_url
  end
end
