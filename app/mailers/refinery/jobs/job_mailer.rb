module Refinery
  module Jobs
    class JobMailer < ActionMailer::Base

      def confirmation(job_application, request)
        @job_application, @request = job_application, request
        mail :subject   => Refinery::Jobs::Setting.confirmation_subject(Globalize.locale),
             :to        => job_application.email,
             :from      => from_info,
             :reply_to  => Refinery::Jobs::Setting.notification_recipients.split(',').first
      end

      def notification(job_application, request)
        @job_application, @request = job_application, request
        @host                      = [request.protocol, request.host_with_port].join
        mail :subject   => Refinery::Jobs::Setting.notification_subject,
             :to        => Refinery::Jobs::Setting.notification_recipients,
             :from      => from_info,
             :reply_to  => job_application.email
      end

      private

      def from_info
        "\"#{from_name}\" <#{from_mail}>"
      end

      def from_name
        ::I18n.t('from_name',
                :scope => 'refinery.jobs.config',
                :site_name => Refinery::Core.site_name,
                :name => @job_application.name)
      end

      def from_mail
        "#{Refinery::Jobs.from_name}@#{@request.domain}"
      end
    end
  end
end