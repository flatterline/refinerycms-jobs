module Refinery
  module Jobs
    module ControllerHelper
      protected
        def find_all_jobs
          @jobs = Refinery::Jobs::Job.published.friendly.page(params[:page])
        end

        def find_job
          @job = Refinery::Jobs::Job.published.friendly.find(params[:id])
        end

        def find_page
          @page = Refinery::Page.friendly.find_by(:link_url => Refinery::Jobs.page_url)
        end

        def new_job_applicaton
          @job_application = Refinery::Jobs::JobApplication.new
        end
    end
  end
end