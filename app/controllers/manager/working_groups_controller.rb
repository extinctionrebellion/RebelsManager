module Manager
  class WorkingGroupsController < BaseController
    def index
      @working_groups = WorkingGroup.all.order(:local_group_id)
    end

    def show
      @working_group = WorkingGroup.find(params[:id])
    end

    def new
      @working_group = WorkingGroup.new
    end

    def create
      @working_group = WorkingGroup.new(working_group_params)
      if @working_group.save
        redirect_to manager_working_group_path(@working_group),
                    notice: "Congrats, we have a new working group!"
      else
        render :new
      end
    end

    def edit
      @working_group = WorkingGroup.find(params[:id])
    end

    def update
      @working_group = WorkingGroup.find(params[:id])
      if @working_group.update(working_group_params)
        redirect_to manager_working_group_path(@working_group),
                    notice: "The working group has been updated."
      else
        render :edit
      end
    end

    private

    def set_presenters
      @menu_presenter = Components::MenuPresenter.new(
        active_primary: 'working_groups'
      )
    end

    def working_group_params
      params.require(:working_group).permit(
        :color,
        :local_group_id,
        :name
      )
    end
  end
end
