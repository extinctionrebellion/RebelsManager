module Pages
  class BaseSection < SitePrism::Section
    extend SitePrismExtension
    include ResourcesHelper
    include Capybara::AliasHelper
    include Capybara::ComplexInputsHelper
  end
end
