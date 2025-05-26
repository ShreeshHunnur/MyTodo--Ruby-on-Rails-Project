require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = todos(:one)
  end

  # Index Action Tests
  test "should get index" do
    get todos_url
    assert_response :success
    assert_not_nil assigns(:todos)
  end

  test "should filter todos by state" do
    get todos_url, params: { state: 'pending' }
    assert_response :success
    assert assigns(:todos).all? { |todo| todo.state == 'pending' }
  end

  test "should search todos by name" do
    get todos_url, params: { search: @todo.name }
    assert_response :success
    assert_includes assigns(:todos), @todo
  end

  test "should combine search and state filter" do
    get todos_url, params: { search: @todo.name, state: @todo.state }
    assert_response :success
    assert assigns(:todos).all? { |todo| todo.state == @todo.state && todo.name.include?(@todo.name) }
  end

  # Show Action Tests
  test "should show todo" do
    get todo_url(@todo)
    assert_response :success
    assert_equal @todo, assigns(:todo)
  end

  test "should handle non-existent todo" do
    get todo_url(id: 999999)
    assert_redirected_to todos_path
    assert_equal "Todo not found.", flash[:alert]
  end

  # New Action Tests
  test "should get new" do
    get new_todo_url
    assert_response :success
    assert_not_nil assigns(:todo)
  end

  # Create Action Tests
  test "should create todo" do
    assert_difference("Todo.count") do
      post todos_url, params: { todo: { name: "New Todo", description: "Description", state: "pending" } }
    end
    assert_redirected_to todos_path
    assert_equal "Todo was successfully created!", flash[:notice]
  end

  test "should not create todo with invalid params" do
    assert_no_difference("Todo.count") do
      post todos_url, params: { todo: { name: "", description: "Description", state: "pending" } }
    end
    assert_response :unprocessable_entity
    assert_not_empty assigns(:todo).errors[:name]
  end

  test "should not create todo with invalid state" do
    assert_no_difference("Todo.count") do
      post todos_url, params: { todo: { name: "New Todo", description: "Description", state: "invalid_state" } }
    end
    assert_response :unprocessable_entity
    assert_not_empty assigns(:todo).errors[:state]
  end

  # Edit Action Tests
  test "should get edit" do
    get edit_todo_url(@todo)
    assert_response :success
    assert_equal @todo, assigns(:todo)
  end

  test "should handle edit of non-existent todo" do
    get edit_todo_url(id: 999999)
    assert_redirected_to todos_path
    assert_equal "Todo not found.", flash[:alert]
  end

  # Update Action Tests
  test "should update todo" do
    patch todo_url(@todo), params: { todo: { name: "Updated Name", description: "Updated Description", state: "doing" } }
    assert_redirected_to todos_path
    assert_equal "Todo was successfully updated!", flash[:notice]
    @todo.reload
    assert_equal "Updated Name", @todo.name
    assert_equal "Updated Description", @todo.description
    assert_equal "doing", @todo.state
  end

  test "should not update todo with invalid params" do
    patch todo_url(@todo), params: { todo: { name: "", description: "Updated Description", state: "doing" } }
    assert_response :unprocessable_entity
    assert_not_empty assigns(:todo).errors[:name]
  end

  test "should not update todo with invalid state" do
    patch todo_url(@todo), params: { todo: { name: "Updated Name", description: "Updated Description", state: "invalid_state" } }
    assert_response :unprocessable_entity
    assert_not_empty assigns(:todo).errors[:state]
  end

  # Destroy Action Tests
  test "should destroy todo" do
    assert_difference("Todo.count", -1) do
      delete todo_url(@todo)
    end
    assert_redirected_to todos_path
    assert_equal "Todo was successfully deleted!", flash[:notice]
  end

  test "should handle destroy of non-existent todo" do
    delete todo_url(id: 999999)
    assert_redirected_to todos_path
    assert_equal "Todo not found.", flash[:alert]
  end

  # Update State Action Tests
  test "should update todo state" do
    patch update_state_todo_url(@todo), params: { state: "done" }
    assert_redirected_to todos_path
    assert_equal "Todo state was successfully updated!", flash[:notice]
    @todo.reload
    assert_equal "done", @todo.state
  end

  test "should not update todo state with invalid state" do
    patch update_state_todo_url(@todo), params: { state: "invalid_state" }
    assert_redirected_to todos_path
    assert_equal "Failed to update todo state.", flash[:alert]
    @todo.reload
    assert_not_equal "invalid_state", @todo.state
  end
end 