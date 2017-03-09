# frozen_string_literal: true
require 'test_helper'
module Automations
  class EvaluatorTest < ActiveSupport::TestCase
    setup do
      @browser = TestBrowser.new
      @procedure = FactoryGirl.create(:procedure)
      @service = Automations::Evaluator.new(@procedure, @browser)
    end

    test 'successfully evaluated goto method' do
      @service.run
      assert_not @procedure.broken
    end

    test 'unsuccessfully evaluated goto method' do
      @procedure.category = :button
      @procedure.selector = :css
      @procedure.path = 'no_path'
      @procedure.action = :click
      @service.run
      assert @service.procedure.broken
    end
  end
end
