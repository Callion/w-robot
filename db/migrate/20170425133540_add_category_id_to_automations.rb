# frozen_string_literal: true
class AddCategoryIdToAutomations < ActiveRecord::Migration
  def change
    add_column :automations, :category_id, :interger
  end
end
