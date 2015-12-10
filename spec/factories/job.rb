require "factory_girl"

FactoryGirl.define do
  factory :job, class: "Refinery::Jobs::Job" do
    sequence(:title, "a") { |n| "Test title #{n}" }
    sequence(:description, "b") { |n| "Test description #{n}" }
  end
end