
require 'rubygems'

# Configure Rails Environment
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../dummy/config/environment", __FILE__)

require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

# require 'database_cleaner'
# DatabaseCleaner.strategy = :transaction
# DatabaseCleaner.start

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # config.after(:it) do
  #   DatabaseCleaner.clean
  # end
end

def each_run
  ActiveSupport::Dependencies.clear
  FactoryGirl.reload

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories including factories.
  ([Rails.root.to_s] | ::Refinery::Plugins.registered.pathnames).map{|p|
    Dir[File.join(p, 'spec', 'support', '**', '*.rb').to_s]
  }.flatten.sort.each do |support_file|
    require support_file
  end
end