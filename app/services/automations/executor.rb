# frozen_string_literal: true
module Automations
  class Executor
    attr_reader :automation, :browser

    def initialize(automation, browser)
      @automation = automation
      @browser = browser
    end

    def run
      automation.procedures.by_position.each do |procedure|
        procedure.reload # refresh procedure, if it has been updated in process
        evaluator = Automations::Evaluator.new(procedure, browser)
        evaluator.run
        return false if evaluator.broken
      end
      true
    end

    def close_browser
      browser.close if browser.present?
    end
  end
end
