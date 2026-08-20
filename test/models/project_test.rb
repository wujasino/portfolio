require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "valid with required attributes" do
    project = Project.new(name: "Test", tagline: "Tagline", description: "Opis")
    assert project.valid?
  end

  test "invalid without a name" do
    project = Project.new(tagline: "Tagline", description: "Opis")
    assert_not project.valid?
    assert_includes project.errors[:name], "can't be blank"
  end

  test "invalid with a malformed url" do
    project = Project.new(name: "Test", tagline: "Tagline", description: "Opis", url: "not-a-url")
    assert_not project.valid?
    assert_includes project.errors[:url], "is invalid"
  end

  test "stack defaults to an empty array" do
    project = Project.new(name: "Test", tagline: "Tagline", description: "Opis")
    project.valid?
    assert_equal [], project.stack
  end

  test "stack_list writer parses a comma separated string" do
    project = Project.new(stack_list: "React,  Node.js ,PostgreSQL")
    assert_equal ["React", "Node.js", "PostgreSQL"], project.stack
  end

  test "stack_list reader joins the stack back into a string" do
    project = projects(:presora)
    assert_equal "TypeScript, React", project.stack_list
  end

  test "default_scope orders projects by position" do
    assert_equal [projects(:presora), projects(:automations)], Project.all.to_a
  end
end
