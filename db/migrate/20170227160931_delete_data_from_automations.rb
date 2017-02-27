# frozen_string_literal: true
class DeleteDataFromAutomations < ActiveRecord::Migration
  def change
    remove_column :automations, :data, :text
  end
end
