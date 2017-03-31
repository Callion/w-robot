# frozen_string_literal: true
require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'selenium-webdriver'

Bundler.require(*Rails.groups)

module Wrobot
  class Application < Rails::Application
    config.active_job.queue_adapter = :delayed_job
    
    # SELECT YOUR "#{browser_type}"_path ACCORDING TO YOUR OPERATING SYSTEM //lib/drivers/.

    config.firefox_path = 'lib/drivers/os_x/geckodriver'
    config.chrome_path = 'lib/drivers/os_x/chromedriver'

    config.active_record.raise_in_transactional_callbacks = true
  end
end
