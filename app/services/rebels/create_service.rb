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
      @rebel.source = @source
      @rebel.language ||= ENV['XR_BRANCH_DEFAULT_LANGUAGE']
      case @source
      when "admin"
        @rebel.consent = true
        @rebel.local_group ||= @local_group
        @rebel.attributes = rebel_admin_params(params)
      when "public"
        @rebel.attributes = rebel_public_params(params)
      end
      validate_email_format! if @rebel.valid?
      generate_token
      delete_existing_rebel_if_no_local_group(@rebel.email)
      @rebel.save!
      Mailtrain::AddSubscriptionsJob.perform_later(@rebel)
      GeocodeRebelJob.perform_later(@rebel) if @rebel.postcode.present?
      true
    end

    def redirect_url
      case @source
      when "admin"
        @rebel
      when "public"
        rebel.redirect || rebel.profile_url
      end
    end

    private

    # We prefer a new and clean signup than keeping an old record that is not
    # linked to a local group
    def delete_existing_rebel_if_no_local_group(email)
      existing_rebel = Rebel.where(email: email, local_group_id: nil)&.take
      if existing_rebel
        Rebels::DeleteService.new(rebel: existing_rebel).run!
      end
    end

    def generate_token
      @rebel.token = SecureRandom.hex(16).to_i(16).to_s(36)
    end

    def rebel_admin_params(params)
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
          :active,
          skill_ids: [],
          working_group_ids: []
        )
    end

    def rebel_public_params(params)
      params.require(:rebel).permit(
        :availability,
        :consent,
        :email,
        :language,
        :local_group_id,
        :name,
        :notes,
        :phone,
        :postcode,
        :redirect,
        :tag_list,
        :willingness_to_be_arrested,
        :agree_with_principles,
        :active,
        skill_ids: [],
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
