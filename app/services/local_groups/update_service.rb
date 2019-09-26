module LocalGroups
  class UpdateService < ServiceBase
    PreconditionFailedError = Class.new(StandardError)

    attr_reader :local_group

    def initialize(local_group:)
      @local_group = local_group
      @report_errors = true
    end

    def run(params = {})
      context = {
        params: params
      }

      catch_error(context: context) do
        run!(params)
      end
    end

    def run!(params = {})
      current_email = local_group.email
      local_group.attributes = local_group_params(params)
      validate_email_format!
      local_group.save!

      # local group has a new email address
      if local_group.email != current_email
        unsubscribe_from_local_groups_list(current_email)
        subscribe_to_local_groups_list
      end
      true
    end

    private

    def subscribe_to_local_groups_list
      MailtrainService.instance.add_subscription(
        ENV['MAILTRAIN_LOCAL_GROUPS_LIST_ID'],
        {
          "EMAIL": @local_group.email,
          "MERGE_NAME": @local_group.name,
          "FORCE_SUBSCRIBE": "yes",
          "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
        }
      )
    end

    def local_group_params(params)
      params
        .require(:local_group)
        .permit(
          :email,
          :mailtrain_list_id,
          :name,
          :welcome_email_body
        )
    end

    def unsubscribe_from_local_groups_list(email)
      MailtrainService.instance.delete_subscription(
        ENV['MAILTRAIN_LOCAL_GROUPS_LIST_ID'],
        {
          "EMAIL": email
        }
      )
    end

    def validate_email_format!
      if ValidatesEmailFormatOf::validate_email_format(local_group.email) == nil
        true # email is valid
      else
        raise PreconditionFailedError,
              "Please double check the provided email address."
      end
    end
  end
end
