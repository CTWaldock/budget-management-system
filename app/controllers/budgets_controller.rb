class BudgetsController < ApplicationController

  def new
    @budget = current_user.budgets.build
  end

  def create
    @budget = current_user.budgets.build(budget_params)
    if @budget.save
      redirect_to budget_path(@budget)
    else
      render :new
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :start_date, :end_date, :limit)
  end

end
