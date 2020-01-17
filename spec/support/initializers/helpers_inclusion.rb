RSpec.configure do |c|
  c.include ::Rails.application.routes.url_helpers
  c.include Capybara::AliasHelper
  c.include Capybara::ComplexInputsHelper
  c.include ResourcesHelper
  c.include EmailsHelper
  c.include FactoryBot::Syntax::Methods

  c.include Devise::Test::ControllerHelpers, type: :controller

  c.include Warden::Test::Helpers, type: :request
  c.include ApiHelper, type: :request


  c.include Warden::Test::Helpers, type: :system
end

FactoryBot::SyntaxRunner.include ResourcesHelper
