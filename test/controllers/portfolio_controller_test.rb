require "test_helper"

class PortfolioControllerTest < ActionDispatch::IntegrationTest
  test "renders the homepage with projects and grouped skills" do
    get root_path

    assert_response :success
    assert_select "h1", "Patryk Rybacki"
    assert_select ".project-card", count: Project.count
    assert_select ".project-card h3", text: projects(:presora).name
    assert_select ".skills-group h3", text: skills(:typescript).category
  end
end
