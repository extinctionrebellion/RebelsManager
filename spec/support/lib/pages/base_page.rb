module Pages
  class BasePage < SitePrism::Page
    extend ::SitePrismExtension
    include ResourcesHelper
    include Capybara::AliasHelper
    include Capybara::ComplexInputsHelper
  end
end
