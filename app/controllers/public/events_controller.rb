class Public::EventsController < Public::BaseController
  layout "public"

  def index
    @events = Event.all.order(starts_at: :desc).map(&method(:decorate))
  end

  def show
    @event = EventDecorator.new(Event.friendly.find(params[:id]))
  end

  private

end
