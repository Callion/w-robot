# frozen_string_literal: true
module Html
  class Browser
    FIREFOX = 'firefox'.freeze
    CHROME = 'chrome'.freeze
    PHANTOMJS = 'phantomjs'.freeze

    BROWSERS = [FIREFOX, CHROME, PHANTOMJS].freeze

    def initialize(timeout, type)
      @timeout = timeout
      @type = type
    end

    def driver
      @driver ||= case @type
                  when CHROME
                    Selenium::WebDriver.for :chrome, driver_path: Rails.application.config.chrome_path
                  when FIREFOX
                    Selenium::WebDriver.for :firefox, driver_path: Rails.application.config.firefox_path
                  when PHANTOMJS
                    Selenium::WebDriver.for :phantomjs
                  end
    end

    def client
      @client ||= Selenium::WebDriver::Remote::Http::Default.new
      return unless @timeout.present?
      @client.read_timeout = @timeout
      @client.open_timeout = @timeout
    end

    def object
      return unless driver.present?
      @browser ||= Watir::Browser.new driver, http_client: client
    end
  end
end
