require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "factory_girl_rails"

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  include FactoryGirl::Syntax::Methods
  include Devise::Test::ControllerHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    sign_in user
  end

  def teardown
    # make sure nobody is left signed in
    sign_out :user
    super
  end
end
