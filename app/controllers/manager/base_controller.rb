module Manager
  class BaseController < ApplicationController
    before_action :authenticate_user!

    layout 'manager'

    def render *args
      set_presenters
      super
    end
  end
end
