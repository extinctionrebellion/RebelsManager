class ApplicationController < ActionController::Base
  layout :layout_by_resource

  before_action :authenticate_user!
  before_action :set_raven_context

  def render *args
    set_presenters unless devise_controller?
    super
  end

  protected

  def layout_by_resource
    devise_controller? ? "public" : "application"
  end

  private

  def set_raven_context
    Raven.user_context(id: current_user.id) if !current_user.nil?
  end
end
