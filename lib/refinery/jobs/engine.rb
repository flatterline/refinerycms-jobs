module Refinery
  module Jobs
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Jobs
      engine_name :refinery_jobs

      config.autoload_paths += %W( #{config.root}/lib )

      initializer 'attach-jobs-resumes-via-refinery-resources-with-dragonfly', :after => 'attach-refinery-resources-with-dragonfly' do |app|
        ::Refinery::Jobs::Dragonfly.configure!
        ::Refinery::Jobs::Dragonfly.attach!(app)
      end

      initializer 'init plugin' do
        Refinery::Plugin.register do |plugin|
          plugin.pathname   = root
          plugin.name       = "refinery_jobs"
          plugin.version    = '2.0.0'
          plugin.menu_match = /(admin|refinery)\/(jobs|vacancies)\/jobs$/
          plugin.activity   = { :class_name => :'refinery/jobs/job' }
          plugin.url        = proc { Refinery::Core::Engine.routes.url_helpers.jobs_admin_jobs_path }
        end

      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Jobs)
      end
    end
  end
end