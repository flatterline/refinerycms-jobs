module Refinery
  module Jobs
    module Dragonfly

      class << self
        def configure!
          ActiveRecord::Base.extend ::Dragonfly::Model
          ActiveRecord::Base.extend ::Dragonfly::Model::Validations

          app_resources = ::Dragonfly.app(:refinery_jobs)

          app_resources.configure do |c|
            datastore :file, {
              :root_path => Refinery::Resources.datastore_root_path
            }
            url_format Refinery::Resources.dragonfly_url_format
            url_host Refinery::Resources.dragonfly_url_host
            secret Refinery::Resources.dragonfly_secret
            response_header 'Content-Disposition' do |job, request, headers|
              "attachment; #{headers['Content-Disposition']}"
            end if Refinery::Resources.content_disposition == :attachment
            dragonfly_url nil
          end

          if ::Refinery::Resources.s3_backend
            require 'dragonfly/s3_data_store'
            options = {
              bucket_name: Refinery::Resources.s3_bucket_name,
              access_key_id: Refinery::Resources.s3_access_key_id,
              secret_access_key: Refinery::Resources.s3_secret_access_key
            }
            options.update(region: Refinery::Resources.s3_region) if Refinery::Resources.s3_region
            app_resources.use_datastore :s3, options
          end
        end

        def attach!(app)
          if defined?(::Rack::Cache)
            unless app.config.action_controller.perform_caching && app.config.action_dispatch.rack_cache
              app.config.middleware.insert 0, ::Rack::Cache, {
                verbose: true,
                metastore: URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/meta"), # URI encoded in case of spaces
                entitystore: URI.encode("file:#{Rails.root}/tmp/dragonfly/cache/body")
              }
            end
            app.config.middleware.insert_after ::Rack::Cache, ::Dragonfly::Middleware, :refinery_jobs
          else
            app.config.middleware.use ::Dragonfly::Middleware, :refinery_jobs
          end
        end
      end

    end
  end
end