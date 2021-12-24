class CategoriesController < ApplicationController
before_action :authenticate
  
  def index
    categories = @current_user.categories.order("created_at ASC")
    render json: categories
  end

  def create
    category = @current_user.categories.create(category_param)
    render json: category
  end

  def update
    category = @current_user.categories.find_by(params[:id])
    category.update(category_param)
    render json: category
  end

  def destroy
    category = @current_user.categories.find(params[:id])
    category.destroy
    head :ok
  end

  private 
    def category_param
      params.require(:category).permit(:title, :color)
    end
end
