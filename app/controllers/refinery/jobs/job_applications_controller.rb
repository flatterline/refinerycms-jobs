module Refinery
  module Jobs
    class JobApplicationsController < ::ApplicationController

      before_filter :find_all_job_applications
      before_filter :find_page

      def new
        @job_application = Refinery::Jobs::JobApplication.new
        @job             = Refinery::Jobs::Job.find(params[:job_id])

        present(@page)
      end

      def create
        @job_application        = Refinery::Jobs::JobApplication.new(params[:job_application])
        @job_application.job_id = params[:job_id]
        @job                    = @job_application.job

        respond_to do |format|
          if @job_application.save
            flash[:notice] = 'Job application was successfully created.'
            begin
              Refinery::Jobs::JobMailer.notification(@job_application, request).deliver
            rescue
              logger.warn "There was an error delivering a notification.\n#{$!}\n"
            end
            format.html { redirect_to refinery.jobs_job_job_application_url(@job, @job_application) }
          else
            format.html { render :action => "new" }
          end
        end
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @jobs in the line below:
      end

      def show
        @job_application = Refinery::Jobs::JobApplication.find(params[:id])
        @job             = @job_application.job

        present(@page)

        respond_to do |format|
          format.html { render :action => 'show' }
          format.xml  { render :xml => @future_student }
        end
      end

    protected

      def find_all_job_applications
        @jobs = Refinery::Jobs::Job.find(:all, :order => "position ASC")
      end

      def find_page
        @page = Refinery::Page.find_by_link_url("/jobs")
      end

    end
  end
end