require 'spec_helper'

module Refinery
  module Jobs
    describe Job, type: :model do
      let(:job) {FactoryGirl.create(:job)}
      describe 'validations' do
        it 'requires title and description' do
          #Negative tests
          expect(FactoryGirl.build(:job, description: nil)).not_to be_valid
          expect(FactoryGirl.build(:job, title: nil)).not_to be_valid
          expect(FactoryGirl.build(:job, title: '')).not_to be_valid
          expect(FactoryGirl.build(:job, description: '')).not_to be_valid

          #Positive tests
          expect(FactoryGirl.build(:job, {description: 1, title: 1})).to be_valid
        end
      end
    end
  end
end