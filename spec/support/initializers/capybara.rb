#/spec/support/initializers/capybara.rb


# because , Capybara Screenshot is much better than Rails Screenshot
require "action_dispatch/system_testing/test_helpers/setup_and_teardown"
::ActionDispatch::SystemTesting::TestHelpers::SetupAndTeardown.module_eval do
  def before_setup
    super
  end

  def after_teardown
    super
  end
end


Capybara.register_driver :chrome do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new
  browser_options.add_argument '--window-size=1920,1080'


  Capybara::Selenium::Driver.new(app, :browser => :chrome, options: browser_options)
end

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end


Capybara.register_driver :selenium_chrome_headless do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new
  browser_options.add_argument '--headless'
  browser_options.add_argument '--mute-audio'
  browser_options.add_argument '--disable-gpu'
  browser_options.add_argument '--window-size=1920,1080'


  driver_opts = {
    # verbose: true,
    log_path: "log/chromedriver.log"
  }


  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options, driver_opts: driver_opts)
end

Capybara.configure do |config|
  config.default_selector = :css
  config.default_max_wait_time= 10
  config.match = :prefer_exact
  # config.ignore_hidden_elements = true
  config.ignore_hidden_elements = false
end


RSpec.configure do |config|

  config.prepend_before(:each, type: :system) do
    Capybara.default_driver = ENV.fetch('DRIVER') { 'rack_test' }.to_sym
    Capybara.javascript_driver = ENV.fetch('DRIVER') { 'selenium_chrome_headless' }.to_sym
    driven_by :selenium_chrome_headless
  end

end



[:chrome, :firefox].each do |driver|
  RSpec.configure do |config|
    config.before(:each,  driver) do
      Capybara.javascript_driver = driver
      Capybara.default_driver = driver
      driven_by driver
    end
  end
end


RSpec.configure do |config|
  config.after(type: :system) do |example|
    Capybara::Screenshot::RSpec.after_failed_example(example)
  end
end


Capybara::Screenshot.register_driver(:selenium_chrome_headless) do |driver, path|
  driver.browser.save_screenshot path
end

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot path
end



Capybara::Screenshot.capybara_tmp_path = Rails.root.join('tmp', 'capybara_screenshots').expand_path
Capybara::Screenshot.prune_strategy = { keep: 10 }
