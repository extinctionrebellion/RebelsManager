module Api
  module Private
    class BaseController < ActionController::Base
      before_action :authenticate_request

      private

      def authenticate_request
        authenticate_or_request_with_http_basic do |username, password|
          username == ENV.fetch('BASIC_AUTH_USERNAME') &&
          password == ENV.fetch('BASIC_AUTH_PASSWORD')
        end
      end
    end
  end
end
