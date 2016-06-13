class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_time_zone

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
    @budget = Budget.find(params[:id])
  end

  def edit
    @budget = Budget.find(params[:id])
  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      redirect_to budget_path(@budget)
    else
      render :edit
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:name, :start_date, :end_date, :limit, :categories_attributes => [:title])
  end

  # Ensure that users are not able to interact with budgets until they have timezones in order to avoid issues with dates.

  def require_time_zone
    redirect_to edit_user_time_zone_path unless current_user.time_zone
  end

end
