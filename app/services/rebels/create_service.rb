module Rebels
  class CreateService < ServiceBase
    PreconditionFailedError = Class.new(StandardError)

    attr_reader :rebel

    def run(params = {})
      context = {
        params: params
      }

      catch_error(context: context) do
        run!(params)
      end
    end

    def run!(params = {})
      @rebel = Rebel.new(params)
      validate_email_format!
      @rebel.save!
      subscribe_to_rebels_list
      true
    end

    def redirect_url
      rebel.redirect || "https://www.extinctionrebellion.be/thank-you.html"
    end

    private

    def subscribe_to_rebels_list
      MailtrainService.instance.subscribe(
        ENV['MAILTRAIN_REBELS_LIST_ID'],
        {
          "EMAIL": @rebel.email,
          "FIRST_NAME": @rebel.name,
          "MERGE_LOCAL_GROUP": @rebel.local_group&.name,
          "MERGE_LANGUAGE": @rebel.language,
          "MERGE_POSTCODE": @rebel.postcode,
          "FORCE_SUBSCRIBE": "yes",
          "TIMEZONE": ENV['XR_BRANCH_TIMEZONE']
        }
      )
    end

    def validate_email_format!
      if ValidatesEmailFormatOf::validate_email_format(rebel.email) == nil
        true # email is valid
      else
        raise PreconditionFailedError,
              "Please double check the email address provided."
      end
    end
  end
end
