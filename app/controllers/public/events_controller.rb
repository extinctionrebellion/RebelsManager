class Public::EventsController < Public::BaseController
  layout "public"

  def index
    events = Event.all
    if params[:scope] == "past"
      events = events
        .before(Time.now, field: :ends_at)
        .order(ends_at: :desc)
    else
      events = events
        .after(Time.now, field: :starts_at)
        .order(starts_at: :desc)
    end
    if params[:local_group_id]
      events = events.where(local_group_id: params[:local_group_id])
    end
    @events = events.map(&method(:decorate))
  end

  def show
    @event = EventDecorator.new(Event.friendly.find(params[:id]))
  end
end
