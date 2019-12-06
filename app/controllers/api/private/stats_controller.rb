module Api
  module Private
    class StatsController < BaseController
      def show
        head 200
        # @TODO: build stats hash and return a json
      end
    end
  end
end
