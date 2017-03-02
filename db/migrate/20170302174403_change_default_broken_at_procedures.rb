class ChangeDefaultBrokenAtProcedures < ActiveRecord::Migration
  def change
    change_column :procedures, :broken, :boolean, default: nil
  end
end
