# frozen_string_literal: true
module Html
  class Browser
    FIREFOX = 'firefox'.freeze
    CHROME = 'chrome'.freeze
    PHANTOMJS = 'phantomjs'.freeze

    BROWSERS = [FIREFOX, CHROME, PHANTOMJS].freeze

    def initialize(options = {})
      @timeout = options[:timeout]
      @type = options[:type]
      start_up
    end

    def start_up
      driver = nil
      case @type
      when CHROME
        driver = Selenium::WebDriver.for :chrome,
                                         driver_path: Rails.application.config.chrome_path
      when FIREFOX
        driver = Selenium::WebDriver.for :firefox,
                                         driver_path: Rails.application.config.firefox_path
      when PHANTOMJS
        driver = Selenium::WebDriver.for :phantomjs
        driver.manage.window.maximize
      else
        return
      end
      @browser ||= Watir::Browser.new driver, http_client: client
    end

    def client
      @client ||= Selenium::WebDriver::Remote::Http::Default.new
      if @timeout.present?
        @client.read_timeout = @timeout
        @client.open_timeout = @timeout
      end
    end

    def object
      @browser
    end
  end
end
