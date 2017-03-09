# frozen_string_literal: true
require 'test_helper'
module Automations
  class ExecutorTest < ActiveSupport::TestCase
    setup do
      @automation = FactoryGirl.create(:automation)
      @automation.procedures << FactoryGirl.create(:procedure)
      @service = Automations::Executor.new(@automation, TestBrowser.new)
    end

    test 'successfully executed' do
      stub_evaluator_with(false)
      assert @service.run
    end

    test 'unsuccessfully executed' do
      stub_evaluator_with(true)
      assert_not @service.run
    end

    private

    def stub_evaluator_with(broken)
      Automations::Evaluator.any_instance.stubs(:run).returns(true)
      Automations::Evaluator.any_instance.stubs(:broken).returns(broken)
    end
  end
end
