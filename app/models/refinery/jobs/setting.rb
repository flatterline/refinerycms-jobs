require 'refinery/setting'

module Refinery
  module Jobs
    class Setting < ::Refinery::Setting

      class << self
        def confirmation_body
          find_or_set(:job_application_confirmation_body,
            "Thank you for your job application %name%,\n\nThis email is a receipt to confirm we have received your job application and we'll be in touch shortly.\n\nThanks."
          )
        end

        def confirmation_subject(locale='en')
          find_or_set(:"job_application_confirmation_subject_#{locale}",
            "Thank you for your job application",
            scoping: "jobs"
          )
        end

        def confirmation_subject=(locales_subjects)
          locales_subjects.each do |locale, subject|
            set(:"job_application_confirmation_subject_#{locale}", {
              value: subject,
              scoping: "jobs"
            })
          end
        end

        def confirmation_message(locale='en')
          find_or_set(:"job_application_confirmation_message_#{locale}", confirmation_body, scoping: "jobs")
        end

        def confirmation_message=(locales_messages)
          locales_messages.each do |locale, message|
            set(:"job_application_confirmation_message_#{locale}", {
              value: message,
              scoping: "jobs"
            })
          end
        end

        def notification_recipients
          recipients = ((Role[:refinery].users.first.email rescue nil) if defined?(Role)).to_s
          find_or_set(:job_application_notification_recipients, recipients, scoping: "jobs")
        end

        def notification_recipients=(recipients)
          set(:job_application_notification_recipients, {
            value: recipients,
            scoping: "jobs"
          })
        end

        def notification_subject
          find_or_set(:job_application_notification_subject, "New job application from your website", scoping: "jobs")
        end

        def send_confirmation?
          find_or_set(:job_application_send_confirmation, true, scoping: "jobs")
        end
      end
    end
  end
end