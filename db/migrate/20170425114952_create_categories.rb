# frozen_string_literal: true
class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :color, default: '#000000'
      t.integer :priority, default: 0
    end
  end
end
