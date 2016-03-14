class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_household

  def current_household
    @current_household ||= Household.find_by(id: session[:household_id])
  end
end
