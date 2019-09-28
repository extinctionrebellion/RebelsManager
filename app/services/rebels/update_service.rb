module Rebels
  class UpdateService < ServiceBase
    PreconditionFailedError = Class.new(StandardError)

    attr_reader :rebel

    def initialize(rebel:)
      @rebel = rebel
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
      current_email = rebel.email
      current_local_group = rebel.local_group
      rebel.attributes = rebel_params(params)
      validate_email_format!
      rebel.save!

      # rebel switches from one local group to another
      if rebel.local_group_id != current_local_group&.id
        unsubscribe_from_rebels_local_list(current_local_group, current_email)
        subscribe_to_rebels_local_list
      end

      # rebel has a new email address
      if rebel.email != current_email
        unsubscribe_from_rebels_list(current_email)
        unsubscribe_from_rebels_local_list(current_local_group, current_email)
        subscribe_to_rebels_list
        subscribe_to_rebels_local_list
      end
      true
    end

    private

    def subscribe_to_rebels_local_list
      return if @rebel.local_group&.mailtrain_list_id.nil?
      MailtrainService.instance.add_subscription(
        @rebel.local_group.mailtrain_list_id,
        {
          "EMAIL": @rebel.email,
          "MERGE_NAME": @rebel.name,
          "FORCE_SUBSCRIBE": "yes",
          "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
        }
      )
    end

    def subscribe_to_rebels_list
      MailtrainService.instance.add_subscription(
        ENV['MAILTRAIN_REBELS_LIST_ID'],
        {
          "EMAIL": @rebel.email,
          "MERGE_NAME": @rebel.name,
          "MERGE_LOCAL_GROUP": @rebel.local_group&.name,
          "MERGE_LANGUAGE": @rebel.language,
          "MERGE_POSTCODE": @rebel.postcode,
          "MERGE_PROFILE_URL": @rebel.profile_url,
          "FORCE_SUBSCRIBE": "yes",
          "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
        }
      )
    end

    def rebel_params(params)
      params
        .require(:rebel)
        .permit(
          :email,
          :interests,
          :internal_notes,
          :irl,
          :language,
          :local_group_id,
          :name,
          :notes,
          :phone,
          :postcode,
          :status,
          :tag_list,
          :willingness_to_be_arrested,
          skill_ids: [],
          working_group_ids: []
        )
    end

    def unsubscribe_from_rebels_local_list(local_group, email)
      return if local_group&.mailtrain_list_id.nil?
      MailtrainService.instance.delete_subscription(
        local_group.mailtrain_list_id,
        {
          "EMAIL": email
        }
      )
    end

    def unsubscribe_from_rebels_list(email)
      MailtrainService.instance.delete_subscription(
        ENV['MAILTRAIN_REBELS_LIST_ID'],
        {
          "EMAIL": email
        }
      )
    end

    def validate_email_format!
      if ValidatesEmailFormatOf::validate_email_format(rebel.email) == nil
        true # email is valid
      else
        raise PreconditionFailedError,
              _("Please double check the email address provided.")
      end
    end
  end
end
