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
      Mailtrain::DeleteSubscriptionsJob.perform_later(current_email, current_local_group&.id)
      Mailtrain::AddSubscriptionsJob.perform_later(rebel)
      true
    end

    private

    def rebel_params(params)
      params
        .require(:rebel)
        .permit(
          :availability,
          :email,
          :interests,
          :internal_notes,
          :irl,
          :language,
          :local_group_id,
          :name,
          :notes,
          :number_of_arrests,
          :phone,
          :postcode,
          :regular_volunteer,
          :status,
          :tag_list,
          :willingness_to_be_arrested,
          skill_ids: [],
          working_group_ids: []
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
