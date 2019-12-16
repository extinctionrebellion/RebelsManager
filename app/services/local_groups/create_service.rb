module LocalGroups
  class CreateService < ServiceBase
    attr_reader :local_group

    def initialize
      @local_group = LocalGroup.new
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
      @local_group.attributes = local_group_params(params)
      validate_email_format!
      @local_group.save!
      subscribe_to_local_groups_list
      true
    end

    private

    def local_group_params(params)
      params
        .require(:local_group)
        .permit(
          :email,
          :mailtrain_list_id,
          :name
        )
    end

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

    def validate_email_format!
      return unless local_group.email.present?
      if ValidatesEmailFormatOf::validate_email_format(local_group.email) == nil
        true # email is valid
      else
        raise PreconditionFailedError,
              "Please double check the provided email address."
      end
    end
  end
end
