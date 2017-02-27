# frozen_string_literal: true
require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'selenium-webdriver'

Bundler.require(*Rails.groups)

module Wrobot
  class Application < Rails::Application
    # SELECT YOUR driver_path ACCORDING TO YOUR OPERATING SYSTEM //lib/drivers/.

    Selenium::WebDriver::Chrome.driver_path = 'lib/drivers/linux/chromedriver'
    Selenium::WebDriver::Firefox.driver_path = 'lib/drivers/linux/geckodriver'

    config.active_record.raise_in_transactional_callbacks = true
  end
end
