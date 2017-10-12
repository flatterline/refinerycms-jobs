class AddFieldsToJobs < ActiveRecord::Migration
  def up
    add_column :refinery_jobs, :fill, :integer, default: 1
    add_column :refinery_jobs, :ref, :string
    add_column :refinery_jobs, :employment_date, :date

    Refinery::Jobs::Job.add_translation_fields! education: :string
    Refinery::Jobs::Job.add_translation_fields! experience: :string
    Refinery::Jobs::Job.add_translation_fields! skills: :string
    Refinery::Jobs::Job.add_translation_fields! languages: :string
    Refinery::Jobs::Job.add_translation_fields! salary: :string
    Refinery::Jobs::Job.add_translation_fields! length: :string
    Refinery::Jobs::Job.add_translation_fields! contact: :string
  end

  def down
    remove_column :refinery_jobs, :fill
    remove_column :refinery_jobs, :ref
    remove_column :refinery_jobs, :employment_date

    remove_column :refinery_job_translations, :education
    remove_column :refinery_job_translations, :experience
    remove_column :refinery_job_translations, :skills
    remove_column :refinery_job_translations, :languages
    remove_column :refinery_job_translations, :salary
    remove_column :refinery_job_translations, :length
    remove_column :refinery_job_translations, :contact
  end
end
