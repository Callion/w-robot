# frozen_string_literal: true
require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'selenium-webdriver'

Bundler.require(*Rails.groups)

module Wrobot
  class Application < Rails::Application
    # SELECT YOUR "#{browser_type}"_path ACCORDING TO YOUR OPERATING SYSTEM //lib/drivers/.

    config.firefox_path = 'lib/drivers/linux/geckodriver'
    config.chrome_path = 'lib/drivers/linux/chromedriver'

    config.active_record.raise_in_transactional_callbacks = true
  end
end
