class RebelsController < BaseController
  include Exportable

  def index
    respond_to do |format|
      format.csv do
        respond_to_csv_for_rebels
      end
      format.html do
        @rebels_index_presenter = RebelsIndexPresenter.new(user: current_user)
      end
      format.json do
        render json: RebelDatatable.new(
          params,
          view_context: view_context,
          user: current_user
        )
      end
    end
  end

  def show
    @rebel = RebelDecorator.new(Rebel.find(params[:id]))
    @mailtrain_lists = MailtrainService.instance
      .get_subscriptions(@rebel.email)
  end

  def new
    @rebel = Rebel.new
  end

  def create
    service = Rebels::CreateService.new(
      source: "admin",
      local_group: current_user&.local_group
    )
    if service.run(params)
      redirect_to service.redirect_url,
                  notice: "Congrats, we have a new rebel!"
    else
      @rebel = service.rebel
      flash.now[:error] = service.error_message unless !@rebel.valid?
      @existing_rebel = existing_rebel_when_present(@rebel)
      render :new
    end
  end

  def edit
    @rebel = Rebel.find(params[:id])
  end

  def update
    service = Rebels::UpdateService.new(rebel: Rebel.find(params[:id]))
    if service.run(params)
      respond_to do |format|
        format.html {
          redirect_to rebel_path(service.rebel),
                      notice: "Rebel has been updated."
        }
        format.js {
          @rebel = service.rebel
        }
      end
    else
      @rebel = service.rebel
      respond_to do |format|
        format.html { render :edit }
        format.js {
          # TODO
        }
      end
    end
  end

  def destroy
    service = Rebels::DeleteService.new(rebel: Rebel.find(params[:id]))
    if service.run!
      redirect_to rebels_path,
                  notice: "Rebel has been deleted."
    else
      redirect_to rebel_path(service.rebel),
                  alert: "Rebel can't be deleted."
    end
  end

  private

  def existing_rebel_when_present(rebel)
    email_error = rebel.errors.details[:email]
    if email_error.any? && email_error.first[:error] == :taken
      Rebel.find_by(email: @rebel.email)
    end
  end

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: 'rebels',
      user: current_user
    )
  end
end
