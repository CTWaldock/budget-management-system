class BudgetsController < ApplicationController
  before_filter :require_time_zone

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

  def show
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :start_date, :end_date, :limit, category_titles: [])
  end

  def require_time_zone
    redirect_to edit_user_time_zone_path if user_signed_in? && !current_user.time_zone
  end

end
