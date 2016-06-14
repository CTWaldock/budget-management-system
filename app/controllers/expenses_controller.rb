class ExpensesController < ApplicationController

  def create
    @category = Category.find(params[:id])
    @expense = @category.expenses.build(expense_params)
    authorize @expense
    if @expense.save
      redirect_to category_path(@category)
    else
      render 'categories/show'
    end
  end

  def destroy
  end

  private

  def expense_params
    params.require(:expense).permit(:cost, :description)
  end

end
