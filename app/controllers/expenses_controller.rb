class ExpensesController < ApplicationController

  def create
    @category = Category.find(params[:category_id])
    @new_expense = @category.expenses.build(expense_params)
    authorize @new_expense
    if @new_expense.save
      render json: @category, status: 201
    else
      render json: { error: @new_expense.errors.full_messages }, status: 422
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @category = @expense.category
    authorize @expense
    @expense.destroy
    redirect_to category_path(@category)
  end

  private

  def expense_params
    params.require(:expense).permit(:cost, :description)
  end

end
