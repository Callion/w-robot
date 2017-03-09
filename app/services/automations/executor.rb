# frozen_string_literal: true
module Automations
  class Executor
    DEFAULT_TIMEOUT = 5

    attr_reader :automation

    def initialize(automation)
      @automation = automation
    end

    def run
      automation.procedures.by_position.each do |procedure|
        evaluator = Automations::Evaluator.new(procedure, browser)
        evaluator.run
        return false if evaluator.broken
      end
      close_browser
      true
    end

    private

    def browser
      @browser ||= Html::Browser.new(timeout: DEFAULT_TIMEOUT, type: automation.browser_type).object
    end

    def close_browser
      browser.close if browser.present?
    end
  end
end
