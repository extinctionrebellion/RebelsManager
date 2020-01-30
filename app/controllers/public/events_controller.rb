class Public::EventsController < Public::BaseController
  layout "public"

  def index
    events = params[:scope] == "past" ? Event.past : Event.upcoming
    if params[:local_group_id]
      events = events.where(local_group_id: params[:local_group_id])
    end
    @events = events.map(&method(:decorate))
  end

  def show
    @event = EventDecorator.new(Event.friendly.find(params[:id]))
  end
end
