class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy update_state ]

  def index
    @todos = Todo.all
    @todos = @todos.by_state(params[:state]) if params[:state].present?
    @todos = @todos.search(params[:search]) if params[:search].present?
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def edit
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to todos_path, notice: "Todo was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: "Todo was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "Todo was successfully deleted!"
  end

  def update_state
    if @todo.update(state: params[:state])
      redirect_to todos_path, notice: "Todo state was successfully updated!"
    else
      redirect_to todos_path, alert: "Failed to update todo state."
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to todos_path, alert: "Todo not found."
  end

  def todo_params
    params.require(:todo).permit(:name, :description, :state)
  end
end