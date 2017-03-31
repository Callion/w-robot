class AddNameIntoProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :name, :string
  end
end
