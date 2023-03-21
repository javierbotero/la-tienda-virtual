class ApplicationController < ActionController::Base
  before_action :authorize_user

  private

  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  def authorize_user
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_url
    end
  end
end
