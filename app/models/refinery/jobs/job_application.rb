require 'refinery/core/base_model'
require 'filters_spam'

module Refinery
  module Jobs
    class JobApplication < Refinery::Core::BaseModel
      self.table_name = 'refinery_job_applications'

      dragonfly_accessor :resume, app: :refinery_jobs

      belongs_to :job, class_name: 'Refinery::Jobs::Job', foreign_key: 'job_id'

      filters_spam message_field:    :cover_letter,
                   email_field:      :email,
                   author_field:     :name,
                   other_fields:     [:phone],
                   extra_spam_words: %w()

      validates_presence_of :name, :phone, :email
      validates :email, format: {
        with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      }, length: { maximum: 255 }
      validates :cover_letter, presence: true, if: :cover_letter_required?
      validates :resume, presence: true, if: :resume_required?
      validates_with Refinery::Jobs::Validators::FileSizeValidator

      def resume_required?
        true
      end

      def cover_letter_required?
        true
      end
    end
  end
end