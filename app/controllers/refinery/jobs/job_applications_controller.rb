module Refinery
  module Jobs
    class JobApplicationsController < ::ApplicationController

      before_action :find_page
      before_action :find_job, only: [:new, :create, :show]

      def new
        @job_application = Refinery::Jobs::JobApplication.new
        present(@page)
      end

      def create
        @job_application = Refinery::Jobs::JobApplication.new(job_application_params)
        @job_application.job_id ||= @job.id

        if !@job_application.job_id.nil?
          if @job_application.save
            if @job_application.ham? || Refinery::Jobs.send_notifications_for_job_applications_marked_as_spam
              begin
                JobMailer.notification(@job_application, request).deliver
              rescue
                logger.warn "There was an error delivering on job application notification.\n#{$!}\n"
              end

              if Refinery::Jobs::Setting.send_confirmation?
                begin
                  JobMailer.confirmation(@job_application, request).deliver
                rescue
                  logger.warn "There was an error delivering on job application confirmation:\n#{$!}\n"
                end
              end
            end

            redirect_to refinery.jobs_job_job_application_path(@job, @job_application)
          else
            render action: 'new'
          end
        else
          error_404
        end
      end

      protected

      def find_job
        @job = Refinery::Jobs::Job.live.friendly.find(params[:job_id] || params[:job_application][:job_id])
      end

      def find_page
        @page = Refinery::Page.friendly.find_by(link_url: Refinery::Jobs.page_url)
      end

      def job_application_params
        params.require(:job_application).permit(permitted_job_application_params)
      end

      private

      def permitted_job_application_params
        [
          :job_id, :name, :email, :phone, :cover_letter, :resume
        ]
      end
    end
  end
end