module Rebels
  class CreateService < ServiceBase
    PreconditionFailedError = Class.new(StandardError)

    attr_reader :rebel, :local_group, :source

    def initialize(source: nil, local_group: nil)
      @rebel = Rebel.new
      @local_group = local_group
      @source = source
    end


    def run(params = {})
      context = {
        params: params,
        local_group: local_group,
        source: source
      }

      catch_error(context: context) do
        run!(params)
      end
    end

    def run!(params = {})
      case @source
      when "admin"
        @rebel.consent = true
        @rebel.local_group ||= @local_group
        @rebel.attributes = rebel_admin_params(params)
      when "public"
        @rebel.attributes = rebel_public_params(params)
      end
      validate_email_format! if @rebel.valid?
      @rebel.save!
      subscribe_to_rebels_list
      subscribe_to_rebels_local_list
      true
    end

    def redirect_url
      case @source
      when "admin"
        @rebel
      when "public"
        rebel.redirect || "https://www.extinctionrebellion.be/thank-you.html"
      end
    end

    private

    def rebel_admin_params(params)
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
          :on_basecamp,
          :phone,
          :postcode,
          :status,
          :tag_list,
          working_group_ids: []
        )
    end

    def rebel_public_params(params)
      params.require(:rebel).permit(
        :consent,
        :name,
        :email,
        :language,
        :local_group_id,
        :notes,
        :phone,
        :postcode,
        :redirect
      )
    end

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
