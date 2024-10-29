require "application_system_test_case"

class BudgetsTest < ApplicationSystemTestCase
  setup do
    @budget = budgets(:one)
  end

  test "visiting the index" do
    visit budgets_url
    assert_selector "h1", text: "Budgets"
  end

  test "should create budget" do
    visit budgets_url
    click_on "New budget"

    fill_in "Bank account", with: @budget.bank_account_id
    fill_in "Current installment", with: @budget.current_installment
    fill_in "Family group", with: @budget.family_group_id
    fill_in "Month", with: @budget.month
    fill_in "Number of installments", with: @budget.number_of_installments
    check "Subscription" if @budget.subscription
    fill_in "Transaction category", with: @budget.transaction_category_id
    fill_in "Value", with: @budget.value
    click_on "Create Budget"

    assert_text "Budget was successfully created"
    click_on "Back"
  end

  test "should update Budget" do
    visit budget_url(@budget)
    click_on "Edit this budget", match: :first

    fill_in "Bank account", with: @budget.bank_account_id
    fill_in "Current installment", with: @budget.current_installment
    fill_in "Family group", with: @budget.family_group_id
    fill_in "Month", with: @budget.month
    fill_in "Number of installments", with: @budget.number_of_installments
    check "Subscription" if @budget.subscription
    fill_in "Transaction category", with: @budget.transaction_category_id
    fill_in "Value", with: @budget.value
    click_on "Update Budget"

    assert_text "Budget was successfully updated"
    click_on "Back"
  end

  test "should destroy Budget" do
    visit budget_url(@budget)
    click_on "Destroy this budget", match: :first

    assert_text "Budget was successfully destroyed"
  end
end
