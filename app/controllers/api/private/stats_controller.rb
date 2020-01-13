module Api
  module Private
    class StatsController < BaseController
      def show
        render json: { total: Rebel.count }
      end
    end
  end
end
