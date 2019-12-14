module Rebels
  class Public::UpdateService < ServiceBase
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
      service = Rebels::UpdateService.new(rebel: rebel)
      if service.run(params)
        rebel.update_column :self_updated_at, DateTime.now
      else
        raise service.error
      end
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
          :language,
          :local_group_id,
          :name,
          :notes,
          :phone,
          :postcode
        )
    end
  end
end
