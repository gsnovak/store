require 'test_helper'

class Admin::CouponsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, params: { coupon: attributes_for(:coupon) }
    assert_redirected_to admin_coupons_path
  end

  test "should get edit" do
    coupon = create(:coupon)
    get :edit, params: {id: coupon.id }
    assert_response :success
  end

  test "should get update" do
    coupon = create(:coupon)
    patch :update, params: { id: coupon.id, coupon: attributes_for(:coupon) }
    assert_redirected_to admin_coupons_path
  end

  test "should get destroy" do
    coupon = create(:coupon)
    delete :destroy, params: { id: coupon.id }
    assert_redirected_to admin_coupons_path
  end

  test "should be secure" do
    coupon = create(:coupon)
    teardown
    get :edit, params: {id: coupon.id }
    assert_redirected_to '/'
  end
end
