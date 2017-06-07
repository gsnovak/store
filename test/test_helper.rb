require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "factory_girl_rails"

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end
