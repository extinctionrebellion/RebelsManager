module Manager
  class RebelsController < BaseController
    def index
      @rebels = Rebel.all.order(created_at: :desc)
    end

    def show
      @rebel = Rebel.find(params[:id])
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

    private

    def rebel_params
      params.require(:rebel).permit(
        :name,
        :email,
        :phone,
        :notes
      )
    end

    def set_presenters
      @menu_presenter = Components::MenuPresenter.new(
        active_primary: 'rebels'
      )
    end
  end
end
