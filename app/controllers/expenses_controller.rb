class ExpensesController < ApplicationController

  def create
    @category = Category.find(params[:category_id])
    @new_expense = @category.expenses.build(expense_params)
    authorize @new_expense
    if @new_expense.save
      redirect_to category_path(@category)
    else
      #need to obtain @expenses in order to render 'categories/show' properly in case of failure
      @expenses = @category.expenses.order(:created_at => :desc)
      render 'categories/show'
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
