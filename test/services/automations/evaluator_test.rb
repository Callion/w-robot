# frozen_string_literal: true
require 'test_helper'
module Automations
  class EvaluatorTest < ActiveSupport::TestCase
    setup do
      @browser = OpenStruct.new(goto: '')
      @procedure = FactoryGirl.create(:procedure, script: "goto ='google.cz'")
      @service = Automations::Evaluator.new(@procedure, @browser)
    end

    test 'successfully evaluated goto method' do
      @service.run
      assert_not @procedure.broken
    end

    test 'unsuccessfully evaluated goto method' do
      @procedure.script = "hello ''"
      @service.run
      assert @service.procedure.broken
    end
  end
end
