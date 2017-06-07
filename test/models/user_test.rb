require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = create(:user)
    assert user.valid?
  end

  test 'user invalid without user_name' do
    user = create(:user)
    user.email = nil
    user.user_name = nil
    refute user.valid?
    assert_not_empty  user.errors[:email]
    assert_not_empty  user.errors[:user_name]
  end

  test 'should have unique user_name' do
    user1 = User.create(user_name: 'not_unique', password: 'password', email: 'email1@email.com')
    assert user1.valid?, "user1 was not valid #{user1.errors.inspect}"

    user2 = User.create(user_name: 'not_unique', password: 'password', email: 'email2@email.com')
    assert_not user2.valid?
    assert_not_empty user2.errors[:user_name]
  end

  test 'should have unique email' do
    user1 = User.create(user_name: 'unique1', password: 'password', email: 'email1@email.com')
    assert user1.valid?, "user1 was not valid #{user1.errors.inspect}"

    user2 = User.create(user_name: 'unique2', password: 'password', email: 'email1@email.com')
    assert_not user2.valid?
    assert_not_empty  user2.errors[:email]
  end
end
