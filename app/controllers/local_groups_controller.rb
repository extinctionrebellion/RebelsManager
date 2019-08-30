class LocalGroupsController < ApplicationController
  before_action :authenticate_user!
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
    @local_group = LocalGroup.new(local_group_params)
    if @local_group.save
      redirect_to local_group_path(@local_group),
                  notice: "Congrats, we have a new local group!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @local_group.update(local_group_params)
      redirect_to local_group_path(@local_group),
                  notice: "The local group has been updated."
    else
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

  def get_local_group
    @local_group = LocalGroup.find(params[:id])
  end
end
