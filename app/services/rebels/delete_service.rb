module Rebels
  class DeleteService < ServiceBase
    attr_reader :rebel

    def initialize(rebel:)
      @rebel = rebel
    end

    def run
      catch_error do
        run!
      end
    end

    def run!
      Mailtrain::DeleteSubscriptionsJob.perform_later(@rebel.email, @rebel.local_group_id)
      @rebel.destroy
      true
    end
  end
end
