RSpec.configure do |config|

  config.before(:suite) do
    # Start by making sure our tests start with a clean slate
    FactoryBot.reload
  end
end
