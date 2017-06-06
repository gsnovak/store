require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = create(:user)
    assert user.valid?
  end

  test 'invalid without user_name' do
    user = create(:user)
    user.user_name = nil
    assert_not_nil user.errors[:name], 'no validation error for name'
  end

  test 'invalid without email' do
    user = create(:user)
    user.email = nil
    refute user.valid?
    assert_not_nil user.errors[:email]
  end
end
