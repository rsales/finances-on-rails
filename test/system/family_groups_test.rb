require "application_system_test_case"

class FamilyGroupsTest < ApplicationSystemTestCase
  setup do
    @family_group = family_groups(:one)
  end

  test "visiting the index" do
    visit family_groups_url
    assert_selector "h1", text: "Family groups"
  end

  test "should create family group" do
    visit family_groups_url
    click_on "New family group"

    fill_in "Name", with: @family_group.name
    click_on "Create Family group"

    assert_text "Family group was successfully created"
    click_on "Back"
  end

  test "should update Family group" do
    visit family_group_url(@family_group)
    click_on "Edit this family group", match: :first

    fill_in "Name", with: @family_group.name
    click_on "Update Family group"

    assert_text "Family group was successfully updated"
    click_on "Back"
  end

  test "should destroy Family group" do
    visit family_group_url(@family_group)
    click_on "Destroy this family group", match: :first

    assert_text "Family group was successfully destroyed"
  end
end
