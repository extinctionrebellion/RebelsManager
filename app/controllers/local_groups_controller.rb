class LocalGroupsController < BaseController
  before_action :redirect_unless_admin
  before_action :get_local_group, only: [:show, :edit, :update, :destroy]

  def index
    @local_groups = LocalGroup.all.order(:name)
  end

  def show
  end

  def new
    @local_group = LocalGroup.new
  end

  def create
    service = LocalGroups::CreateService.new
    if service.run(params)
      redirect_to local_group_path(service.local_group),
                  notice: "Congrats, we have a new local group!"
    else
      @local_group = service.local_group
      set_error_flash(service.local_group, service.error_message)
      render :new
    end
  end

  def edit
  end

  def update
    service = LocalGroups::UpdateService.new(
      local_group: LocalGroup.find(params[:id])
    )
    if service.run(params)
      redirect_to local_group_path(service.local_group),
                  notice: "The local group has been updated."
    else
      @local_group = service.local_group
      set_error_flash(service.local_group, service.error_message)
      render :edit
    end
  end

  def destroy
    if @local_group.destroyable_by?(current_user) && @local_group.destroy
      redirect_to local_groups_path(),
                  notice: "The local group has been deleted."
    else
      flash.now[:alert] = "A local group must have no rebel anymore to be deleted."
      render :show
    end
  end

  private

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: "local_groups"
    )
  end

  def get_local_group
    @local_group = LocalGroup.find(params[:id])
  end
end
