module Manager
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :set_raven_context

    layout 'manager'

    def render *args
      set_presenters
      super
    end

    def set_raven_context
      Raven.user_context(id: current_user.id) if !current_user.nil?
    end
  end
end
