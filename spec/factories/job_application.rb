require "factory_girl"

FactoryGirl.define do
  factory :job_application, class: "Refinery::Jobs::JobApplication" do
    sequence(:name, "a") { |n| "Job application name #{n}" }
    phone "321-123-1234"
    sequence(:email, "b") { |n| "refinery_#{n}@exemple.com" }
    sequence(:email, "c") { |n| "Cover letter #{n}" }
    resume ""
  end
end