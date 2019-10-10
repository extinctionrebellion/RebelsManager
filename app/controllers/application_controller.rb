class ApplicationController < ActionController::Base
  include DecoratorHelpers

  layout :layout_by_resource

  before_action :set_raven_context

  protected

  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end

  def public_controller?
    self.class.to_s.split("::")&.first == "Public"
  end

  private

  def set_raven_context
    Raven.user_context(id: current_user.id) if !current_user.nil?
  end
end
