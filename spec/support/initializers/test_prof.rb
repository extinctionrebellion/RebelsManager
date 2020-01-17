require 'test_prof/recipes/rspec/before_all'
require "test_prof/recipes/rspec/factory_default"
require 'test_prof/recipes/rspec/let_it_be'
require 'test_prof/factory_prof'


TestProf.configure do |config|
  # the directory to put artifacts (reports) in ('tmp/test_prof' by default)
  config.output_dir = 'tmp/test_prof'

  # use unique filenames for reports (by simply appending current timestamp)
  config.timestamps = true

  # color output
  config.color = true
end

TestProf::FactoryProf.run

# TestProf::BeforeAll.adapter = TestProf::BeforeAll::Adapters::ActiveRecord
