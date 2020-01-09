class EventsController < BaseController
  before_action :get_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all.order(starts_at: :desc)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    service = Events::CreateService.new
    if service.run(params)
      redirect_to event_path(service.event),
                  notice: "Congrats, we have a new event!"
    else
      @event = service.event
      set_error_flash(service.event, service.error_message)
      render :new
    end
  end

  def edit
  end

  def update
    service = Events::UpdateService.new(
      event: Event.find(params[:id])
    )
    if service.run(params)
      redirect_to event_path(service.event),
                  notice: "The event has been updated."
    else
      @event = service.event
      set_error_flash(service.event, service.error_message)
      render :edit
    end
  end

  def destroy
    if @event.destroyable_by?(current_user) && @event.destroy
      redirect_to events_path(),
                  notice: "The local group has been deleted."
    else
      flash.now[:alert] = "An error occured."
      render :show
    end
  end

  private

  def get_event
    @event = Event.friendly.find(params[:id])
  end

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: "events"
    )
  end
end
