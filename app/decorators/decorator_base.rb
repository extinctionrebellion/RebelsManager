class DecoratorBase < SimpleDelegator
  include ApplicationHelper
  include ActionView::Context
  include ActionView::Helpers
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TranslationHelper
  include ActionView::Helpers::UrlHelper
  include Webpacker::Helper
  include Rails.application.routes.url_helpers

  def class
    __getobj__.class
  end

  def target
    __getobj__
  end

  def value_or_hyphen(value)
    ActionController::Base.helpers.strip_tags(value || "").length > 0 ? value : "-"
  end
end
