# frozen_string_literal: true
class AddFillIntoColumnIntoProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :fill_into, :integer
  end
end
