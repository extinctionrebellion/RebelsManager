class LocalGroupsController < ApplicationController
  before_action :authenticate_user!

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
    @local_group = LocalGroup.find(params[:id])
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

  private

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: "local_groups"
    )
  end
end
