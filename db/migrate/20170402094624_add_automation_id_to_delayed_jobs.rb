class AddAutomationIdToDelayedJobs < ActiveRecord::Migration
  def change
    add_column :delayed_jobs, :automation_id, :interger
  end
end
