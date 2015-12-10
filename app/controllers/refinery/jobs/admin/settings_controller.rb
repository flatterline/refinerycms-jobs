module Refinery
  module Jobs
    module Admin
      class SettingsController < Refinery::AdminController

        before_filter :find_setting, :only => [:edit, :update]
        after_filter :save_subject_for_confirmation,
          :save_message_for_confirmation, :save_notification_recipients, :only => :update

        def edit
        end

        def update
          flash[:notice] = t('refinery.crudify.updated', :what => @setting.name.gsub("job_", "").titleize)

          unless request.xhr? or from_dialog?
            redirect_back_or_default(refinery.jobs_admin_jobs_path)
          else
            render text: "<script type='text/javascript'>parent.window.location = '#{refinery.jobs_admin_jobs_path}';</script>"
          end
        end

      protected

        def find_setting
          setting = params[:id].gsub("job_", "")

          if Refinery::Jobs::Setting.respond_to?(setting)
            Refinery::Jobs::Setting.send(setting)
          end

          @setting = Refinery::Setting.friendly.find(params[:id])
        end

        def save_notification_recipients
          if setting_params.include?('value')
            Refinery::Jobs::Setting.notification_recipients = setting_params[:value]
          end
        end

        def save_subject_for_confirmation
          if setting_params.include?('subject')
            Refinery::Jobs::Setting.confirmation_subject = setting_params[:subject]
          end
        end

        def save_message_for_confirmation
          if setting_params.include?('message')
            Refinery::Jobs::Setting.confirmation_message = setting_params[:message]
          end
        end

      private

        def setting_params
          params.require(:setting).permit(:value,
            subject: Refinery::I18n.frontend_locales,
            message: Refinery::I18n.frontend_locales)
        end

      end
    end
  end
end