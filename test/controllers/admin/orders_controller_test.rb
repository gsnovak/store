require 'test_helper'

class Admin::OrdersControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, params: { order: attributes_for(:order) }
    assert_response :success
  end

  test "should get edit" do
    order = create(:order )
    get :edit, params: {id: order.id }
    assert_response :success
  end

  test "should get update" do
    order = create(:order)
    patch :update, params: { id: order.id, order: attributes_for(:order) }
    assert_redirected_to admin_orders_path
  end

  test "should get destroy" do
    order = create(:order)
    delete :destroy, params: { id: order.id }
    assert_redirected_to admin_orders_path
  end

  test "should be secure" do
    coupon = create(:order)
    teardown
    get :edit, params: {id: coupon.id }
    assert_redirected_to '/'
  end

end
