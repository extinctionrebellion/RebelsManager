source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'acts-as-taggable-on', '~> 6.0', github: 'spark-solutions/acts-as-taggable-on', branch: 'fix/rails-6-and-failing-specs'
gem 'ajax-datatables-rails'
gem 'annotate'
gem 'awesome_print'
gem 'devise', '~> 4.7'
gem 'ffaker'
gem 'gettext_i18n_rails'
gem 'rack-cors'
gem 'rest-client'
gem 'sentry-raven'
gem 'sidekiq', '5.2.7'
gem 'simple_form', '~> 5.0'
gem 'slim', '~> 4.0'
gem 'validates_email_format_of'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Modern encryption for Rails
gem 'lockbox'

# Securely search encrypted database fields
gem 'blind_index'

# Keep personally identifiable information (PII) out of logs
gem 'logstop'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  # Find translations or build .mo files
  gem 'gettext', '>=3.0.2', require: false
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Find translations inside haml/slim files
  gem 'ruby_parser', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.30', require: false
  gem 'capybara-screenshot', require: false
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'site_prism', '~> 3.0.2', require: false
  gem 'test-prof' , '~> 0.7.5', require: false
  gem 'vcr', '~> 4.0.0', require: false
  gem 'webmock', '~> 3.5.1', require: false
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Prevent polling on BSD
require 'rbconfig'
if RbConfig::CONFIG['target_os'] =~ /(?i-mx:bsd|dragonfly)/
  gem 'rb-kqueue', '>= 0.2'
end
