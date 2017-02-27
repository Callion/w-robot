class CreateAutomations < ActiveRecord::Migration
  def change
    create_table :automations do |t|
      t.string :name
      t.boolean :active
      t.string :data

      t.timestamps null: false
    end
  end
end
