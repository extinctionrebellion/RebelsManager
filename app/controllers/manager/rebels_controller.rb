module Manager
  class RebelsController < BaseController
    def index
      if current_user.local_group
        @rebels = Rebel
          .where(local_group: current_user.local_group)
          .order(created_at: :desc)
      else
        @rebels = Rebel.all.order(created_at: :desc)
      end
    end

    def show
      @rebel = Rebel.find(params[:id])
    end

    def new
      @rebel = Rebel.new
    end

    def create
      service = Rebels::CreateService.new(source: "admin")
      if service.run(params)
        redirect_to manager_rebel_path(service.rebel),
                    notice: "Congrats, we have a new rebel!"
      else
        @rebel = service.rebel
        flash.now[:error] = service.error_message unless !@rebel.valid?
        render :new
      end
    end

    def edit
      @rebel = Rebel.find(params[:id])
    end

    def update
      service = Rebels::UpdateService.new(rebel: Rebel.find(params[:id]))
      if service.run(params)
        redirect_to manager_rebel_path(service.rebel),
                    notice: "Rebel has been updated."
      else
        render :edit
      end
    end

    def destroy
      service = Rebels::DeleteService.new(rebel: Rebel.find(params[:id]))
      if service.run!
        redirect_to manager_rebels_path,
                    notice: "Rebel has been deleted."
      else
        redirect_to manager_rebel_path(service.rebel),
                    alert: "Rebel can't be deleted."
      end
    end

    private

    def set_presenters
      @menu_presenter = Components::MenuPresenter.new(
        active_primary: 'rebels'
      )
    end
  end
end
