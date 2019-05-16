module Manager
  class BaseController < ApplicationController
    before_action :authenticate_user!

    layout 'manager'
  end
end
