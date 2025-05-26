require "test_helper"

class TodoTest < ActiveSupport::TestCase
  def setup
    @todo = Todo.new(
      name: "Test Todo",
      description: "Test Description",
      state: "pending"
    )
  end

  # Validation Tests
  test "should be valid with valid attributes" do
    assert @todo.valid?
  end

  test "should require a name" do
    @todo.name = nil
    assert_not @todo.valid?
    assert_includes @todo.errors[:name], "can't be blank"
  end

  test "should require a description" do
    @todo.description = nil
    assert_not @todo.valid?
    assert_includes @todo.errors[:description], "can't be blank"
  end

  test "should require a state" do
    todo = Todo.new(name: "Test", description: "Test")
    Todo.skip_callback(:validation, :before, :set_default_state)
    todo.state = nil
    assert_not todo.valid?
    assert_includes todo.errors[:state], "can't be blank"
    Todo.set_callback(:validation, :before, :set_default_state)
  end

  test "should validate state inclusion" do
    @todo.state = "invalid_state"
    assert_not @todo.valid?
    assert_includes @todo.errors[:state], "is not included in the list"
  end

  test "should accept valid states" do
    valid_states = %w[pending doing done]
    valid_states.each do |state|
      @todo.state = state
      assert @todo.valid?, "#{state} should be a valid state"
    end
  end

  # Scopes Tests
  test "should filter by state" do
    pending_todo = Todo.create!(name: "Pending", description: "Test", state: "pending")
    doing_todo = Todo.create!(name: "Doing", description: "Test", state: "doing")
    done_todo = Todo.create!(name: "Done", description: "Test", state: "done")

    assert_includes Todo.by_state("pending"), pending_todo
    assert_includes Todo.by_state("doing"), doing_todo
    assert_includes Todo.by_state("done"), done_todo
    assert_not_includes Todo.by_state("pending"), doing_todo
  end

  test "should search by name" do
    todo1 = Todo.create!(name: "Ruby on Rails", description: "Test", state: "pending")
    todo2 = Todo.create!(name: "Python Django", description: "Test", state: "pending")
    todo3 = Todo.create!(name: "JavaScript React", description: "Test", state: "pending")

    results = Todo.search("ruby")
    assert_includes results, todo1
    assert_not_includes results, todo2
    assert_not_includes results, todo3
  end

  test "should search case-insensitively" do
    todo = Todo.create!(name: "Ruby on Rails", description: "Test", state: "pending")
    
    assert_includes Todo.search("ruby"), todo
    assert_includes Todo.search("RUBY"), todo
    assert_includes Todo.search("Ruby"), todo
  end

  test "should combine search and state filter" do
    todo1 = Todo.create!(name: "Ruby Task", description: "Test", state: "pending")
    todo2 = Todo.create!(name: "Ruby Task", description: "Test", state: "doing")
    todo3 = Todo.create!(name: "Python Task", description: "Test", state: "pending")

    results = Todo.search("ruby").by_state("pending")
    assert_includes results, todo1
    assert_not_includes results, todo2
    assert_not_includes results, todo3
  end

  # Default Values Tests
  test "should set default state to pending" do
    todo = Todo.new(name: "Test", description: "Test")
    todo.save
    assert_equal "pending", todo.state
  end

  # Timestamps Tests
  test "should set created_at on creation" do
    todo = Todo.create!(name: "Test", description: "Test", state: "pending")
    assert_not_nil todo.created_at
  end

  test "should update updated_at on save" do
    todo = Todo.create!(name: "Test", description: "Test", state: "pending")
    original_updated_at = todo.updated_at
    sleep(1) # Ensure time difference
    todo.update!(name: "Updated")
    assert todo.updated_at > original_updated_at
  end

  # Edge Cases
  test "should handle very long names" do
    @todo.name = "a" * 255
    assert @todo.valid?
  end

  test "should handle very long descriptions" do
    @todo.description = "a" * 1000
    assert @todo.valid?
  end

  test "should handle special characters in name" do
    @todo.name = "!@#$%^&*()_+-=[]{}|;:,.<>?/~`"
    assert @todo.valid?
  end

  test "should handle special characters in description" do
    @todo.description = "!@#$%^&*()_+-=[]{}|;:,.<>?/~`"
    assert @todo.valid?
  end

  test "should handle whitespace in name" do
    @todo.name = "   Test Todo   "
    assert @todo.valid?
    assert_equal "Test Todo", @todo.name.strip
  end

  test "should handle whitespace in description" do
    @todo.description = "   Test Description   "
    assert @todo.valid?
    assert_equal "Test Description", @todo.description.strip
  end
end 