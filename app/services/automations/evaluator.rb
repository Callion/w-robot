# frozen_string_literal: true
module Automations
  class Evaluator
    attr_reader :procedure, :browser, :broken

    def initialize(procedure, browser)
      @procedure = procedure
      @browser = browser
      @broken = false
      @value = ''
    end

    def run
      @value = procedure_evaluation
    rescue
      @broken = true
    ensure
      if procedure.fill_into.present?
        next_procedure = procedure.automation.procedures.find_by(position: procedure.fill_into)
        next_procedure.update(input: @value) if next_procedure
      end
      procedure.update(broken: broken)
    end

    private

    def procedure_evaluation
      if category.present? && input.present?
        browser.send(category, selector, path).send(action, input)
      elsif category.present?
        browser.send(category, selector, path).send(action)
      elsif input.present?
        browser.send(action, input)
      else
        browser.send(action)
      end
    end

    def category
      procedure.category
    end

    def selector
      procedure.to_html_tag(procedure.selector).to_sym
    end

    def path
      procedure.path
    end

    def action
      procedure.action
    end

    def input
      procedure.input
    end
  end
end
