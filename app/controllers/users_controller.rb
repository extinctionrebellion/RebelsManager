class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_unless_admin

  def index
    @users = User.all.order(:email)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user),
                  notice: "Congrats, we have a new user!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user),
                  notice: "User has been updated."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path,
                  notice: "User has been deleted."
    else
      redirect_to user_path(@user),
                  alert: "User can't be deleted."
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :local_group_id
    )
  end

  def redirect_unless_admin
    redirect_to root_path and return if !current_user.admin?
  end

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: 'users'
    )
  end
end
