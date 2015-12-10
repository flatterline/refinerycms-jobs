module Refinery
  module Jobs
    class JobApplicationsController < ::ApplicationController
      include ControllerHelper

      before_filter :find_page
      before_filter :find_job, :only => [:new]

      def new
        @job_application = Refinery::Jobs::JobApplication.new

        present(@page)
      end

      def create
        @job_application = Refinery::Jobs::JobApplication.new(job_application_params)

        if @job_application.job_id
          @job_id_integer  = Refinery::Jobs::Job.find_by_slug_or_id(job_application_params[:job_id])
        else
          @job_id_integer  = Refinery::Jobs::Job.find_by_slug_or_id(params[:job_id])
        end

        if !@job_id_integer.nil?
          @job_application.job_id = @job_id_integer.id
          @job                    = @job_application.job

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

            redirect_to refinery.jobs_job_job_application_url(@job, @job_application)
          else
            render :action => 'new'
          end
        else
          error_404
        end
      end

      def show
        @job_application = Refinery::Jobs::JobApplication.find(params[:id])
        @job             = @job_application.job

        present(@page)

        respond_to do |format|
          format.html { render :action => 'show' }
        end
      end

      private

      def job_application_params
        params.require(:job_application).permit!
      end

      def permitted_job_application_params
        [
          :name, :email, :phone, :cover_letter, :resume
        ]
      end
    end
  end
end