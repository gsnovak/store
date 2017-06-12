require 'test_helper'

class CreditCardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get credit_card_index_url
    assert_response :success
  end

  test "should get new" do
    get credit_card_new_url
    assert_response :success
  end

  test "should get create" do
    get credit_card_create_url
    assert_response :success
  end

  test "should get show" do
    get credit_card_show_url
    assert_response :success
  end

  test "should get edit" do
    get credit_card_edit_url
    assert_response :success
  end

  test "should get update" do
    get credit_card_update_url
    assert_response :success
  end

  test "should get destroy" do
    get credit_card_destroy_url
    assert_response :success
  end

end
