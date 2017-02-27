class AddBrokenColumnIntoProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :broken, :boolean, default: false
  end
end
