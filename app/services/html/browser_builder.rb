# frozen_string_literal: true
module Html
  class BrowserBuilder
    DEFAULT_TIMEOUT = 5

    attr_reader :browser_type

    def initialize(browser_type)
      @browser_type = browser_type
    end

    def build
      @browser ||= Html::Browser.new(DEFAULT_TIMEOUT, browser_type).object
    end
  end
end
