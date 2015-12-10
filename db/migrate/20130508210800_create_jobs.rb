class CreateJobs < ActiveRecord::Migration

  def change
    create_table :refinery_jobs do |t|
      t.string      :title
      t.text        :description
      t.string      :employment_terms
      t.string      :hours
      t.integer     :position
      t.boolean     :enabled
      t.timestamps
    end

    add_index :refinery_jobs, :id

    # can't use Model.table_name as it would load class and initializers haven't run to attach refinery_resources dragonfly app
    create_table :refinery_job_applications do |t|
      t.integer     :job_id
      t.string      :name
      t.string      :phone
      t.string      :email
      t.text        :cover_letter
      t.string      :resume_uid
      t.string      :resume_name
      t.timestamps
    end

    add_index :refinery_job_applications, :id
    add_index :refinery_job_applications, :job_id
  end
end