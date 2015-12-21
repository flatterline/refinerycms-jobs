class CreateJobTranslations < ActiveRecord::Migration
  def up
    Refinery::Jobs::Job.create_translation_table!({
      :title => :string,
      :description => :text,
      :slug => :string
    }, {
      :migrate_data => true
    })
  end

  def down
    Refinery::Jobs::Job.drop_translation_table! :migrate_data => true
  end
end
