require "test_helper"

class Admin::SkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @skill = skills(:typescript)
    @credentials = ActionController::HttpAuthentication::Basic.encode_credentials("admin", "admin")
  end

  test "requires authentication" do
    get admin_skills_path
    assert_response :unauthorized
  end

  test "lists skills when authenticated" do
    get admin_skills_path, headers: { "Authorization" => @credentials }
    assert_response :success
    assert_select "td", text: @skill.name
  end

  test "creates a skill with valid params" do
    assert_difference "Skill.count", 1 do
      post admin_skills_path,
        params: { skill: { category: "Deploy", name: "Netlify" } },
        headers: { "Authorization" => @credentials }
    end

    assert_redirected_to admin_skills_path
  end

  test "does not create a duplicate skill in the same category" do
    assert_no_difference "Skill.count" do
      post admin_skills_path,
        params: { skill: { category: @skill.category, name: @skill.name } },
        headers: { "Authorization" => @credentials }
    end

    assert_response :unprocessable_content
  end

  test "deletes a skill" do
    assert_difference "Skill.count", -1 do
      delete admin_skill_path(@skill), headers: { "Authorization" => @credentials }
    end

    assert_redirected_to admin_skills_path
  end
end
