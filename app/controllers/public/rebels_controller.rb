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

  def edit
    redirect_to root_path and return unless expected_params_for_edit
    # t = Time.now
    @rebel = Rebel.where(
      email: params[:email],
      id: params[:id]
      # token: params[:id]
    ).take
    @rebel = nil unless @rebel&.created_at&.to_i == params[:time].to_i
    # Avoid timed attacks by always having the same timing
    # sleep_value = (2000 - (Time.now + t) * 1000.0) / 1000.0
    # sleep(sleep_value)
  end

  def update
    # TODO find using id, email, timestamp and token
    @rebel = Rebel.where(
      email: params[:email],
      id: params[:id]#, # TODO don't expose rebel ID (uuid?)
      # token: params[:t]
    ).take
    # TODO validate using params[:time]
    service = Rebels::Public::UpdateService.new(rebel: @rebel)
    if service.run(params)
      redirect_to edit_public_rebel_path(@rebel, email: @rebel.email, time: @rebel.created_at.to_i),
                  notice: "Thanks a lot! Your rebel profile is now up-to-date."
    else
      render :edit
    end
  end

  private

  def expected_params_for_edit
    params[:id].present? && params[:time].present? && params[:email].present?
  end
end
