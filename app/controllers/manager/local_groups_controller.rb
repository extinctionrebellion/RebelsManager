module Manager
  class LocalGroupsController < BaseController
    def index
      @local_groups = LocalGroup.all.order(:name)
    end

    def show
      @local_group = LocalGroup.find(params[:id])
    end

    def new
      @local_group = LocalGroup.new
    end

    def create
      @local_group = LocalGroup.new(local_group_params)
      if @local_group.save
        redirect_to manager_local_group_path(@local_group),
                    notice: "Congrats, we have a new local group!"
      else
        render :new
      end
    end

    def edit
      @local_group = LocalGroup.find(params[:id])
    end

    def update
      @local_group = LocalGroup.find(params[:id])
      if @local_group.update(local_group_params)
        redirect_to manager_local_group_path(@local_group),
                    notice: "The local group has been updated."
      else
        render :edit
      end
    end

    private

    def local_group_params
      params.require(:local_group).permit(
        :email,
        :mailtrain_list_id,
        :name
      )
    end

    def set_presenters
      @menu_presenter = Components::MenuPresenter.new(
        active_primary: 'local_groups'
      )
    end
  end
end
