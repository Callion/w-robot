# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
Dir[Rails.root.join('test/support/**/*')].each { |f| require f }
require 'rails/test_help'
require 'mocha/mini_test'

module ActionSupport
  class TestCase
    include FactoryGirl::Syntax::Methods
  end
end

module ActionController
  class TestCase
    include Devise::Test::ControllerHelpers
  end
end
