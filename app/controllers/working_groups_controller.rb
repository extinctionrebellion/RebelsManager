class WorkingGroupsController < BaseController
  before_action :get_working_group, only: [:show, :edit, :update, :destroy]

  def index
    @working_groups = WorkingGroup.all.order(:local_group_id)
  end

  def show
  end

  def new
    @working_group = WorkingGroup.new
  end

  def create
    service = WorkingGroups::CreateService.new
    if service.run(params)
      redirect_to working_group_path(service.working_group),
                  notice: "Congrats, we have a new working group!"
    else
      @working_group = service.working_group
      set_error_flash(service.working_group, service.error_message)
      render :new
    end
  end

  def edit
  end

  def update
    service = WorkingGroups::UpdateService.new(
      working_group: @working_group
    )
    if service.run(params)
      redirect_to working_group_path(service.working_group),
                  notice: "The working group has been updated."
    else
      @working_group = service.working_group
      set_error_flash(service.working_group, service.error_message)
      render :edit
    end
  end

  private

  def get_working_group
    @working_group = WorkingGroup.find(params[:id])
  end

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: 'working_groups'
    )
  end
end
