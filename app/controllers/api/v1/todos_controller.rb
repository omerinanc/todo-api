class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: %i[ show update destroy ]

  def index
    render json: Todo.all
  end

  def create
    todo = Todo.create(todo_params)
    render json: todo
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    head :no_content
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end
  
  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:id, :text, :completed)
  end
end

