class Public::RegistrationsController < Public::BaseController
  layout "public"

  def new
    @action = Action.find(params[:action_id])
    @registration = Registration.new(action: @action)
  end

  def create
    @action = Action.find(params[:action_id])
    service = Registrations::CreateService.new(action: @action)
    if service.run(params)
      redirect_to service.redirect_url
    else
      @registration = service.registration
      set_error_flash(service.registration, service.error_message)
      render :new
    end
  end
end
