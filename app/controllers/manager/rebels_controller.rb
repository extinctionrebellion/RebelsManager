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
      service = Rebels::CreateService.new
      if service.run(rebel_params.merge(consent: true))
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
      @rebel = Rebel.find(params[:id])
      if @rebel.update(rebel_params)
        redirect_to manager_rebel_path(@rebel),
                    notice: "La fiche du rebelle a été mise à jour."
      else
        render :edit
      end
    end

    def destroy
      @rebel = Rebel.find(params[:id])
      if @rebel.destroy
        redirect_to manager_rebels_path,
                    notice: "Rebel has been deleted."
      else
        redirect_to manager_rebel_path(@rebel),
                    alert: "Rebel can't be deleted."
      end
    end

    private

    def rebel_params
      params.require(:rebel).permit(
        :email,
        :interests,
        :internal_notes,
        :irl,
        :language,
        :local_group_id,
        :name,
        :notes,
        :on_basecamp,
        :phone,
        :postcode,
        :status,
        :tag_list,
        working_group_ids: []
      )
    end

    def set_presenters
      @menu_presenter = Components::MenuPresenter.new(
        active_primary: 'rebels'
      )
    end
  end
end
