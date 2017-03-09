# frozen_string_literal: true
require 'test_helper'
module Html
  class BrowserTest < ActiveSupport::TestCase
    test 'successfully builded browser with PhantomJs' do
      type = 'phantomjs'
      set_service(type)
      assert @service.driver.browser.to_s, type
    end

    test 'successfully builded browser with Firefox' do
      type = 'firefox'
      set_service(type)
      assert @service.driver.browser.to_s, type
    end

    test 'successfully builded browser with Chrome' do
      type = 'chrome'
      set_service(type)
      assert @service.driver.browser.to_s, type
    end

    private

    def set_service(type)
      Selenium::WebDriver.stubs(:for).returns(OpenStruct.new(browser: type.to_sym))
      @service ||= Html::Browser.new(5, type)
    end
  end
end
