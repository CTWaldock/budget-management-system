class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_user_time_zone


  private

  # Users require a timezone in order for budgets to work properly.

  def set_user_time_zone
    Time.zone = current_user.time_zone if current_user.try(:time_zone)
  end

end
