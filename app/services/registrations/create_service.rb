module Registrations
  class CreateService < ServiceBase
    PreconditionFailedError = Class.new(StandardError)

    attr_reader :action, :registration

    def initialize(action: nil)
      @action = action
    end

    def run(params = {})
      context = {
        params: params,
        action: action
      }

      catch_error(context: context) do
        run!(params)
      end
    end

    def run!(params = {})
      @registration = action.registrations.new
      @registration.attributes = registration_params(params)
      validate_email_format! if @registration.valid?
      @registration.save!
      Mailtrain::AddRegistrationJob.perform_later(@registration)
      true
    end

    def redirect_url
      case registration.language
      when "fr"
        "https://forms.organise.earth/index.php?r=survey/index&sid=243848&newtest=Y&Name=#{registration.name}&email=#{registration.email}"
      when "en"
        "https://forms.organise.earth/index.php?r=survey/index&sid=713324&newtest=Y&Name=#{registration.name}&email=#{registration.email}"
      when "nl"
        "https://forms.organise.earth/index.php?r=survey/index&sid=881517&newtest=Y&Name=#{registration.name}&email=#{registration.email}"
      when "de"
        "https://forms.organise.earth/index.php?r=survey/index&sid=243848&newtest=Y&Name=#{registration.name}&email=#{registration.email}"
      end
    end

    private

    def registration_params(params)
      params
        .require(:registration)
        .permit(
          :email,
          :language,
          :name,
          :participated_previously
        )
    end

    def validate_email_format!
      if ValidatesEmailFormatOf::validate_email_format(registration.email) == nil
        true # email is valid
      else
        raise PreconditionFailedError,
              _("Please double check the email address provided.")
      end
    end
  end
end
