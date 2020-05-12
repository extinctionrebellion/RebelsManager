class BaseController < ActionController::Base
  layout "application"

  before_action :authenticate_user!
  before_action :redirect_ringer
  before_action :set_locale

  def render *args
    set_presenters
    super
  end

  private

  def redirect_unless_admin
    redirect_to root_path and return if !current_user.admin?
  end

  def redirect_ringer
    if current_user.ringer? &&
        !(controller_name == "calls" || (controller_name == "rebels" && action_name == "update"))
      redirect_to calls_path and return
    end
  end

  def set_error_flash(object, error_message)
    if object.valid?
      flash.now[:error] = "Unexpected error: #{error_message}"
    else
      flash.now[:error] = object.errors.messages.values.flatten.join("<br>")
    end
  end

  def set_locale
    I18n.locale = :en
  end
end
