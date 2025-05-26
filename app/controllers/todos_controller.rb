class TodosController < ApplicationController
  def index
    @todos = Todo.all
    
    # Apply search filter if present
    @todos = @todos.where("name LIKE ?", "%#{params[:search].strip}%") if params[:search].present?
    
    # Apply state filter if present
    @todos = @todos.where(state: params[:state]) if params[:state].present?
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      flash[:notice] = "Todo was successfully created!"
      redirect_to todos_path(@todo)
    else
      Rails.logger.debug "Todo errors: #{@todo.errors.full_messages}"
      render :new
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      flash[:notice] = "Todo was successfully updated!"
      redirect_to todos_path(@todo)
    else
      Rails.logger.debug "Todo errors: #{@todo.errors.full_messages}"
      render :edit
    end
  end

  def update_state
    @todo = Todo.find(params[:id])
    if @todo.update(state: params[:state])
      flash[:notice] = "Todo state was successfully updated!"
    else
      flash[:alert] = "Failed to update todo state."
    end
    redirect_to todos_path
  end

  def destroy
    @todo = Todo.find(params[:id])
    if @todo.destroy
      flash[:notice] = "Todo was successfully deleted!"
    else
      flash[:alert] = "Failed to delete todo."
    end
    redirect_to todos_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Todo not found."
    redirect_to todos_path
  end
  
  private

  def todo_params
    params.require(:todo).permit(:name, :description, :state)
  end
end