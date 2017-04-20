# frozen_string_literal: true
class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :message
      t.integer :user_id

      t.timestamps null: false
    end

    add_foreign_key :logs, :users
  end
end
