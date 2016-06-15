class StaticController < ApplicationController

  def home
    if user_signed_in?
      redirect_to user_budgets_path
    else
      redirect_to new_user_session_path
    end
  end

end
