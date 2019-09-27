class SkillsController < BaseController
  before_action :redirect_unless_admin

  def index
    @skills = Skill.all.order(:name)
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      redirect_to skill_path(@skill),
                  notice: "New skill added successfully."
    else
      render :new
    end
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    if @skill.update(skill_params)
      redirect_to skill_path(@skill),
                  notice: "The skill has been updated."
    else
      render :edit
    end
  end

  def destroy
    @skill = Skill.find(params[:id])
    if @skill.destroy
      redirect_to skills_path,
                  notice: "The skill has been deleted."
    else
      flash.now[:alert] = "We're sorry but this skill cannot be deleted."
      render :show
    end
  end

  private

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: "skills"
    )
  end

  def skill_params
    params.require(:skill).permit(
      :description,
      :name
    )
  end
end
