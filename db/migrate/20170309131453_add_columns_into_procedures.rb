# frozen_string_literal: true
class AddColumnsIntoProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :category, :integer
    add_column :procedures, :selector, :integer
    add_column :procedures, :path, :string
    add_column :procedures, :action, :integer
    add_column :procedures, :input, :string

    remove_column :procedures, :script, :string
  end
end
