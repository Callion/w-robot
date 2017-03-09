# frozen_string_literal: true
module Automations
  class Evaluator
    attr_reader :procedure, :browser, :broken

    def initialize(procedure, browser)
      @procedure = procedure
      @browser = browser
      @broken = false
    end

    def run
      eval('browser.' + procedure.script)
    rescue
      @broken = true
    ensure
      procedure.update(broken: broken)
    end
  end
end
