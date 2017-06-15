require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, params: { product: attributes_for(:product) }
    assert_redirected_to admin_products_path
  end

  test "should get edit" do
    product = create(:product)
    get :edit, params: {id: product.id }
    assert_response :success
  end

  test "should get update" do
    product = create(:product)
    patch :update, params: { id: product.id, product: attributes_for(:product) }
    assert_redirected_to admin_products_path
  end

  test "should get destroy" do
    product = create(:product)
    delete :destroy, params: { id: product.id }
    assert_redirected_to admin_products_path
  end

  test "should be secure" do
    coupon = create(:product)
    teardown
    get :edit, params: {id: coupon.id }
    assert_redirected_to '/'
  end

end
