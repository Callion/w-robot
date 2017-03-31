# frozen_string_literal: true
class AddColumnsToAutomations < ActiveRecord::Migration
  def change
    add_column :automations, :execute_at, :datetime
    add_column :automations, :repetition, :integer
  end
end
