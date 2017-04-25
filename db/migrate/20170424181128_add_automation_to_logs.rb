class AddAutomationToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :automation_id, :interger
  end
end
