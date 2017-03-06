# frozen_string_literal: true
class AddUserIdToAutomations < ActiveRecord::Migration
  def change
    add_column :automations, :user_id, :integer
    add_foreign_key :automations, :users
  end
end
