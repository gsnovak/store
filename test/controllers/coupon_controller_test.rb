require 'test_helper'

class CouponControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get coupon_index_url
    assert_response :success
  end

  test "should get new" do
    get coupon_new_url
    assert_response :success
  end

  test "should get create" do
    get coupon_create_url
    assert_response :success
  end

  test "should get show" do
    get coupon_show_url
    assert_response :success
  end

  test "should get edit" do
    get coupon_edit_url
    assert_response :success
  end

  test "should get update" do
    get coupon_update_url
    assert_response :success
  end

  test "should get destroy" do
    get coupon_destroy_url
    assert_response :success
  end

end
