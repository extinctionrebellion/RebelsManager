class SkillsController < BaseController
  before_action :redirect_unless_admin
  before_action :get_skill, only: [:show, :edit, :update, :destroy]

  def index
    @skills = Skill.all.order(:name)
  end

  def new
    @skill = Skill.new
  end

  def create
    service = Skills::CreateService.new
    if service.run(params)
      redirect_to skill_path(service.skill),
                  notice: "Skill added successfully."
    else
      @skill = service.skill
      set_error_flash(service.skill, service.error_message)
      render :new
    end
  end

  def edit
  end

  def update
    service = Skills::UpdateService.new(
      skill: @skill
    )
    if service.run(params)
      redirect_to skill_path(service.skill),
                  notice: "The skill has been updated."
    else
      @skill = service.skill
      set_error_flash(service.skill, service.error_message)
      render :edit
    end
  end

  def destroy
    service = Skills::DeleteService.new(skill: @skill)
    if service.run!
      redirect_to skills_path,
                  notice: "The skill has been deleted."
    else
      redirect_to skill_path(service.skill),
                  alert: "We're sorry but this skill cannot be deleted."
    end
  end

  private

  def get_skill
    @skill = Skill.find(params[:id])
  end

  def set_presenters
    @menu_presenter = Components::MenuPresenter.new(
      active_primary: "skills"
    )
  end
end
