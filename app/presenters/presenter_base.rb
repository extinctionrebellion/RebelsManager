class PresenterBase
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TranslationHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include Webpacker::Helper
  include ActionView::Context
  include ApplicationHelper
  include DecoratorHelpers
  include Rails.application.routes.url_helpers

  private

  # This prevents an error with the link_to helper
  def controller
    nil
  end

  def safe_html(&block)
    block.call.html_safe
  end
end
