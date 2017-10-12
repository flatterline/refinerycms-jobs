class AddSlugToJobs < ActiveRecord::Migration
  def change
    add_column Refinery::Jobs::Job.table_name, :slug, :string
    add_index Refinery::Jobs::Job.table_name, :slug
  end
end