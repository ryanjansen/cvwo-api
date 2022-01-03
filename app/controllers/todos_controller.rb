class TodosController < ApplicationController
  before_action :authenticate
  
  def index
    todos = @current_user.todos.order("created_at DESC")
    render json: todos
  end

  def create
    tp = todo_param
    if tp[:category]
      cat = Category.find(tp[:category])
      tp[:category] = cat
    end
    todo = @current_user.todos.create(tp)
    render json: todo
  end

  def update
    todo = @current_user.todos.find_by(params[:id])
    todo.update(todo_param)
    render json: todo
  end

  def destroy
    todo = @current_user.todos.find(params[:id])
    todo.destroy
    head :ok
  end

  def test
    render json: { message: "test success"}
  end

  private 
    def todo_param
      params.require(:todo).permit(:title, :done, :category, :due_date)
    end
end
