# frozen_string_literal: true
class ChangeAutomationsDataColumnType < ActiveRecord::Migration
  def change
    change_column :automations, :data, :text
  end
end
