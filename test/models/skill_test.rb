require "test_helper"

class SkillTest < ActiveSupport::TestCase
  test "valid with category and name" do
    skill = Skill.new(category: "Deploy", name: "Netlify")
    assert skill.valid?
  end

  test "invalid without a category" do
    skill = Skill.new(name: "Netlify")
    assert_not skill.valid?
    assert_includes skill.errors[:category], "can't be blank"
  end

  test "invalid without a name" do
    skill = Skill.new(category: "Deploy")
    assert_not skill.valid?
    assert_includes skill.errors[:name], "can't be blank"
  end

  test "name must be unique within a category" do
    duplicate = Skill.new(category: skills(:typescript).category, name: skills(:typescript).name)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "has already been taken"
  end

  test "same name is allowed in a different category" do
    skill = Skill.new(category: "Deploy", name: skills(:typescript).name)
    assert skill.valid?
  end
end
