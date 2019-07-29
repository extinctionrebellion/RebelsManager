module Manager
  class RebelsController < BaseController
    def index
      @rebels = Rebel.all.order(created_at: :desc)
    end

    def show
      @rebel = Rebel.find(params[:id])
    end

    def new
      @rebel = Rebel.new
    end

    def create
      @rebel = Rebel.new(rebel_params)
      @rebel.consent = true
      if @rebel.save
        redirect_to manager_rebel_path(@rebel),
                    notice: "Congrats, we have a new rebel!"
      else
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
        :irl,
        :language,
        :local_group_id,
        :name,
        :notes,
        :on_basecamp,
        :phone,
        :postcode,
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
