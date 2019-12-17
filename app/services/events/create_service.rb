module Events
  class CreateService < ServiceBase
    attr_reader :event

    def initialize
      @event = Event.new
      @report_errors = true
    end

    def run(params = {})
      context = {
        params: params,
      }

      catch_error(context: context) do
        run!(params)
      end
    end

    def run!(params = {})
      @event.attributes = event_params(params)
      @event.save!
      true
    end

    private

    def event_params(params)
      params
        .require(:event)
        .permit(
          :name,
          :description,
          :local_group_id,
          :starts_at,
          :ends_at,
          :facebook_url,
        )
    end
  end
end
