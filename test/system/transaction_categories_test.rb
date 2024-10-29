require "application_system_test_case"

class TransactionCategoriesTest < ApplicationSystemTestCase
  setup do
    @transaction_category = transaction_categories(:one)
  end

  test "visiting the index" do
    visit transaction_categories_url
    assert_selector "h1", text: "Transaction categories"
  end

  test "should create transaction category" do
    visit transaction_categories_url
    click_on "New transaction category"

    fill_in "Category type", with: @transaction_category.category_type_id
    fill_in "Family group", with: @transaction_category.family_group_id
    fill_in "Name", with: @transaction_category.name
    click_on "Create Transaction category"

    assert_text "Transaction category was successfully created"
    click_on "Back"
  end

  test "should update Transaction category" do
    visit transaction_category_url(@transaction_category)
    click_on "Edit this transaction category", match: :first

    fill_in "Category type", with: @transaction_category.category_type_id
    fill_in "Family group", with: @transaction_category.family_group_id
    fill_in "Name", with: @transaction_category.name
    click_on "Update Transaction category"

    assert_text "Transaction category was successfully updated"
    click_on "Back"
  end

  test "should destroy Transaction category" do
    visit transaction_category_url(@transaction_category)
    click_on "Destroy this transaction category", match: :first

    assert_text "Transaction category was successfully destroyed"
  end
end
