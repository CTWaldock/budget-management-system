class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    authorize @category
    @expenses = @category.expenses.order(:created_at => :desc)
    @new_expense = @category.expenses.build
  end

  def destroy
    @category = Category.find(params[:id])
    @budget = @category.budget
    authorize @category
    @category.destroy
    redirect_to @budget
  end

end
