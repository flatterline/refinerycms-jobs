class AddSpamToJobApplications < ActiveRecord::Migration
  def change
    add_column :refinery_job_applications, :spam, :boolean
  end
end
