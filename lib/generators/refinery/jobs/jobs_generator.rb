module Refinery
  class JobsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate_jobs_initializer
      template 'config/initializers/refinery/jobs.rb.erb', File.join(destination_root, 'config', 'initializers', 'refinery', 'jobs.rb')
    end

    def rake_db
      rake("refinery_jobs:install:migrations")
      rake("refinery_settings:install:migrations")
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

  # Added by Refinery CMS Jobs engine
  Refinery::Jobs::Engine.load_seed
        EOH
      end
    end
  end
end