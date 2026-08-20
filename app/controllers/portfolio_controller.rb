class PortfolioController < ActionController::Base
  layout "application"

  def index
    @projects = Project.all
    @skills = Skill.all.group_by(&:category).transform_values { |skills| skills.map(&:name) }
  end
end
