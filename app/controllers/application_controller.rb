class ApplicationController < ActionController::Base
  protect_from_forgery 
  before_action :authorize
  helper_method :current_user

  private
  def current_user
    if session[:user_id] 
      @current_user ||= User.find_by_id(session[:user_id]) 
  else
      @current_user = nil
    end
  end

  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url
    end
  end

  def redirect_unless_admin
    unless current_user.is_admin? 
      flash[:error] = 'Not Authorized'
      redirect_to :root
    end
  end
end
