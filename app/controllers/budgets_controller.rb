class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_time_zone

  def index
    @active_budgets = current_user.budgets.active
    @inactive_budgets = current_user.budgets.inactive
    @completed_budgets = current_user.budgets.completed
    respond_to do |f|
      f.html
      f.json { render :json => { active: @active_budgets,
                                 inactive: @inactive_budgets,
                                 completed: @completed_budgets } }
    end
  end

  def new
    @budget = current_user.budgets.build
    render layout: false
  end

  def create
    @budget = current_user.budgets.build(budget_params)
    if @budget.save
      render :show, layout: false, status: 201
    else
      render :new, layout: false, status: 422
    end
  end

  def show
    @budget = Budget.find(params[:id])
    authorize @budget
    render layout: false
  end

  def edit
    @budget = Budget.find(params[:id])
    authorize @budget
    render layout: false
  end

  def update
    @budget = Budget.find(params[:id])
    authorize @budget
    if @budget.update(budget_params)
      render :show, layout: false
    else
      render :edit, layout: false, status: 422
    end
  end

  def destroy
    @budget = Budget.find(params[:id])
    authorize @budget
    @budget.destroy
    redirect_to user_budgets_path
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
