class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    authorize @category
    render json: @category
  end

  def destroy
    @category = Category.find(params[:id])
    @budget = @category.budget
    authorize @category
    @category.destroy
    render 'budgets/show', layout: false
  end

end
