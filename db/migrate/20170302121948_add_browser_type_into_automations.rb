class AddBrowserTypeIntoAutomations < ActiveRecord::Migration
  def change
    add_column :automations, :browser_type, :string
  end
end
