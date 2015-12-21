require 'spec_helper'

module Refinery
  module Jobs
    describe Setting, type: :model do
      context ".notification_recipients=" do
        it "delegates to Refinery::Setting#set" do
          expect(Refinery::Setting).to receive(:set).
            with(:job_application_notification_recipients, {
              value: 'some value',
              scoping: 'jobs'
            })

          Refinery::Jobs::Setting.notification_recipients = "some value"
        end
      end

      context ".confirmation_subject=" do
        it "delegates to Refinery::Setting#set" do
          expect(Refinery::Jobs::Setting).to receive(:set).
            with(:job_application_confirmation_subject_en, {
              value: 'some value',
              scoping: 'jobs'
            })

          Refinery::Jobs::Setting.confirmation_subject = {en: 'some value'}
        end
      end

      context ".confirmation_message=" do
        it "delegates to Refinery::Setting#set" do
          expect(Refinery::Jobs::Setting).to receive(:set).
            with(:job_application_confirmation_message_en, {
              value: 'some value',
              scoping: 'jobs'
            })

          Refinery::Jobs::Setting.confirmation_message = {en: 'some value'}
        end
      end
    end
  end
end