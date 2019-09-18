class BaseController < ActionController::Base
  layout "application"

  before_action :authenticate_user!

  def render *args
    set_presenters
    super
  end

  private

  def set_error_flash(object, error_message)
    if object.valid?
      flash.now[:error] = "Unexpected error: #{error_message}"
    else
      flash.now[:error] = object.errors.messages.values.flatten.join("<br>")
    end
  end
end
