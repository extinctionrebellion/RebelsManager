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
    t = Time.now
    @rebel = Rebel.find(params[:id])
    check_params(@rebel)
    avoid_timed_attacks(t)
  rescue StandardError => e
    Raven.capture_exception(e)
    redirect_to root_path
  end

  def update
    @rebel = Rebel.find(params[:id])
    check_params(@rebel)
    service = Rebels::Public::UpdateService.new(rebel: @rebel)
    if service.run(params)
      redirect_to edit_public_rebel_path(@rebel, a: @rebel.created_at.to_i, b: @rebel.email, c: @rebel.token),
                  notice: "Thanks a lot! Your rebel profile is now up-to-date."
    else
      render :edit
    end
  rescue StandardError => e
    Raven.capture_exception(e)
    redirect_to root_path
  end

  private

  def avoid_timed_attacks(t)
    # Avoid timed attacks by always having the same timing
    sleep_value = (2000 - ((Time.now - t) * 1000.0)) / 1000.0
    ap "sleep_value: #{sleep_value}"
    sleep(sleep_value)
  end

  def check_params(rebel)
    raise "Rebel not found" if rebel.nil?
    if rebel&.created_at&.to_i != params[:a]&.to_i ||
        rebel.token != params[:c] ||
          rebel.email != params[:b]
      raise "Public params validation failed"
    end
  end

  def expected_params_for_edit
    # a: created_at.to_i
    # b: email
    # c: token
    params[:id].present? && params[:a].present? && params[:b].present?
  end
end
