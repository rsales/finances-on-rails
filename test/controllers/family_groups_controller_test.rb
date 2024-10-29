require "test_helper"

class FamilyGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @family_group = family_groups(:one)
  end

  test "should get index" do
    get family_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_family_group_url
    assert_response :success
  end

  test "should create family_group" do
    assert_difference("FamilyGroup.count") do
      post family_groups_url, params: { family_group: { name: @family_group.name } }
    end

    assert_redirected_to family_group_url(FamilyGroup.last)
  end

  test "should show family_group" do
    get family_group_url(@family_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_family_group_url(@family_group)
    assert_response :success
  end

  test "should update family_group" do
    patch family_group_url(@family_group), params: { family_group: { name: @family_group.name } }
    assert_redirected_to family_group_url(@family_group)
  end

  test "should destroy family_group" do
    assert_difference("FamilyGroup.count", -1) do
      delete family_group_url(@family_group)
    end

    assert_redirected_to family_groups_url
  end
end
