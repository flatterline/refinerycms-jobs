module Refinery
  module Jobs
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Jobs
      engine_name :refinery_jobs

      config.autoload_paths += %W( #{config.root}/lib )

      initializer 'attach-refinery-jobs-with-dragonfly', :before => :finisher_hook do |app|
        ::Refinery::Jobs::Dragonfly.configure!
        ::Refinery::Jobs::Dragonfly.attach!(app)
      end

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'refinery_jobs'
          plugin.menu_match = %r{refinery/jobs(/jobs(/.*)?)?(/job_applications(/.*)?)?$}
          plugin.url        = proc { Refinery::Core::Engine.routes.url_helpers.jobs_admin_jobs_path }
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Jobs)
      end
    end
  end
end