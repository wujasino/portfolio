require "test_helper"

class Admin::ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:presora)
    @credentials = ActionController::HttpAuthentication::Basic.encode_credentials("admin", "admin")
  end

  test "requires authentication" do
    get admin_projects_path
    assert_response :unauthorized
  end

  test "lists projects when authenticated" do
    get admin_projects_path, headers: { "Authorization" => @credentials }
    assert_response :success
    assert_select "td", text: @project.name
  end

  test "creates a project with valid params" do
    assert_difference "Project.count", 1 do
      post admin_projects_path,
        params: { project: { name: "Nowy", tagline: "Tag", description: "Opis", stack_list: "Ruby, Rails" } },
        headers: { "Authorization" => @credentials }
    end

    assert_redirected_to admin_projects_path
    assert_equal ["Ruby", "Rails"], Project.find_by(name: "Nowy").stack
  end

  test "does not create a project with invalid params" do
    assert_no_difference "Project.count" do
      post admin_projects_path,
        params: { project: { name: "", tagline: "", description: "" } },
        headers: { "Authorization" => @credentials }
    end

    assert_response :unprocessable_content
  end

  test "updates a project" do
    patch admin_project_path(@project),
      params: { project: { name: "Presora v2" } },
      headers: { "Authorization" => @credentials }

    assert_redirected_to admin_projects_path
    assert_equal "Presora v2", @project.reload.name
  end

  test "deletes a project" do
    assert_difference "Project.count", -1 do
      delete admin_project_path(@project), headers: { "Authorization" => @credentials }
    end

    assert_redirected_to admin_projects_path
  end
end
