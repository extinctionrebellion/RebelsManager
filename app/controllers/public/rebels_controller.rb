class Public::RebelsController < Public::BaseController
  layout "public"

  skip_before_action :verify_authenticity_token, on: [:create]

  def new
    @rebel = Rebel.new
  end

  def create
    service = Rebels::CreateService.new(
      source: "public"
    )
    if service.run(params)
      redirect_to service.redirect_url,
                  notice: "Welcome to the Rebellion!"
    else
      @rebel = service.rebel
      set_error_flash(service.rebel, service.error_message)
      render :new
    end
  end
end
