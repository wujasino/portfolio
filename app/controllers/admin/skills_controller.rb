class Admin::SkillsController < Admin::BaseController
  before_action :set_skill, only: %i[edit update destroy]

  def index
    @skills = Skill.all.group_by(&:category)
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)

    if @skill.save
      redirect_to admin_skills_path, notice: "Umiejętność „#{@skill.name}” została dodana."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @skill.update(skill_params)
      redirect_to admin_skills_path, notice: "Umiejętność „#{@skill.name}” została zaktualizowana."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @skill.destroy
    redirect_to admin_skills_path, notice: "Umiejętność „#{@skill.name}” została usunięta.", status: :see_other
  end

  private

  def set_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:category, :name, :position)
  end
end
