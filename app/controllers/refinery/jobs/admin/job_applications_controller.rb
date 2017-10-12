module Refinery
  module Jobs
    module Admin
      class JobApplicationsController < Refinery::AdminController
        before_action :find_job, only: [:index, :destroy]

        crudify :'refinery/jobs/job_application'


        def index
          if @job
            @job_applications = @job.job_applications.paginate( page: params[:page] )
          end
        end

        def destroy
          Refinery::Jobs::JobApplication.find(params[:id]).destroy
          redirect_to refinery.jobs_admin_job_job_applications_path(@job)
        end


        protected
        
        def find_job
          @job = Refinery::Jobs::Job.find params[:job_id]
        end
      end
    end
  end
end