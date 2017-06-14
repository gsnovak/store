require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get destroy" do
    user = create(:user)
    delete :destroy, params: { id: user.id }
    assert_redirected_to admin_users_path
  end
end
