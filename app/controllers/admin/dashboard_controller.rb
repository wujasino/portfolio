class Admin::DashboardController < Admin::BaseController
  def index
    @projects_count = Project.count
    @skills_count = Skill.count
  end
end
