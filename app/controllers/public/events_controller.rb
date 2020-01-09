class Public::EventsController < Public::BaseController
  layout "public"

  def index
    if params[:scope] == "past"
      @events = Event.all
        .before(Date.today.beginning_of_day, field: :ends_at)
        .order(starts_at: :desc).map(&method(:decorate))
    else
      @events = Event.all
        .after(Date.today.beginning_of_day, field: :starts_at)
        .order(starts_at: :desc).map(&method(:decorate))
    end
  end

  def show
    @event = EventDecorator.new(Event.friendly.find(params[:id]))
  end

  private

end
