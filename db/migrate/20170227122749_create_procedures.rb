class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.integer :automation_id
      t.integer :position
      t.string :script
    end
  end
end
