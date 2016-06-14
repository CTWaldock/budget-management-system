class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    authorize @category
  end

  def destroy
    @category = Category.find(params[:id])
    @budget = @category.budget
    authorize @category
    @category.destroy
    redirect_to @budget
  end

end
