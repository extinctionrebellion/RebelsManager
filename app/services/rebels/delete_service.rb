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
      unsubscribe_from_rebels_list
      unsubscribe_from_rebels_local_list
      @rebel.destroy
      true
    end

    private

    def unsubscribe_from_rebels_local_list
      return if @rebel.local_group&.mailtrain_list_id&.nil?
      MailtrainService.instance.delete_subscription(
        @rebel.local_group.mailtrain_list_id,
        {
          "EMAIL": @rebel.email
        }
      )
    end

    def unsubscribe_from_rebels_list
      MailtrainService.instance.delete_subscription(
        ENV['MAILTRAIN_REBELS_LIST_ID'],
        {
          "EMAIL": @rebel.email
        }
      )
    end
  end
end
