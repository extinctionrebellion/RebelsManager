class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_raven_context

  def render *args
    set_presenters if current_user
    super
  end

  def set_raven_context
    Raven.user_context(id: current_user.id) if !current_user.nil?
  end
end
