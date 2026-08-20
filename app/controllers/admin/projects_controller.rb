class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: %i[edit update destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to admin_projects_path, notice: "Projekt „#{@project.name}” został dodany."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to admin_projects_path, notice: "Projekt „#{@project.name}” został zaktualizowany."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @project.destroy
    redirect_to admin_projects_path, notice: "Projekt „#{@project.name}” został usunięty.", status: :see_other
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :tagline, :description, :url, :repo, :position, :stack_list)
  end
end
