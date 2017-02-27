# frozen_string_literal: true
# Documentation comment
module FormHelper
  def setup_automation(automation)
    3.times { automation.procedures.build }
    automation
  end
end
