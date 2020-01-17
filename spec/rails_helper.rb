require 'spec_helper'
require 'capybara/rspec'
require 'simplecov'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

require 'factory_bot_rails'
require 'test-prof'

require 'capybara'
require 'capybara/rails'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'capybara-screenshot'
require 'capybara-screenshot/rspec'
require 'site_prism'
# require 'capybara/slow_finder_errors'

require 'webmock/rspec'
require 'vcr'
require 'ffaker'


# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

SimpleCov.start 'rails'

Dir[Rails.root.join('spec/support/initializers/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/support/shared_contexts/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.use_transactional_fixtures = true
end
