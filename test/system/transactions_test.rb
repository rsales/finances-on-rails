require "application_system_test_case"

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = transactions(:one)
  end

  test "visiting the index" do
    visit transactions_url
    assert_selector "h1", text: "Transactions"
  end

  test "should create transaction" do
    visit transactions_url
    click_on "New transaction"

    fill_in "Bank account", with: @transaction.bank_account_id
    fill_in "Current installment", with: @transaction.current_installment
    fill_in "Family group", with: @transaction.family_group_id
    fill_in "Month", with: @transaction.month
    fill_in "Number of installments", with: @transaction.number_of_installments
    check "Subscription" if @transaction.subscription
    fill_in "Transaction category", with: @transaction.transaction_category_id
    fill_in "Value", with: @transaction.value
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "should update Transaction" do
    visit transaction_url(@transaction)
    click_on "Edit this transaction", match: :first

    fill_in "Bank account", with: @transaction.bank_account_id
    fill_in "Current installment", with: @transaction.current_installment
    fill_in "Family group", with: @transaction.family_group_id
    fill_in "Month", with: @transaction.month
    fill_in "Number of installments", with: @transaction.number_of_installments
    check "Subscription" if @transaction.subscription
    fill_in "Transaction category", with: @transaction.transaction_category_id
    fill_in "Value", with: @transaction.value
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "should destroy Transaction" do
    visit transaction_url(@transaction)
    click_on "Destroy this transaction", match: :first

    assert_text "Transaction was successfully destroyed"
  end
end
