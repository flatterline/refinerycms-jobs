module Refinery
  module Jobs
    module Admin
      class JobsController < Refinery::AdminController
        crudify :'refinery/jobs/job',
                order: 'position ASC',
                include: [:translations, :job_applications]

        private

        def job_params
          params.require(:job).permit permitted_job_params
        end

        def permitted_job_params
          [
            :title, :description, :employment_terms, :hours, :position, :draft, :published_at, :fill,
            :ref, :education, :experience, :skills, :languages, :salary, :length, :employment_date, :contact
          ]
        end
      end
    end
  end
end