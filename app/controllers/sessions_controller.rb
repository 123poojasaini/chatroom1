class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && User.authenticate(params[:email],params[:password])
      session[:user_id] = user.id
      redirect_to home_user_path(user)
    else
      flash[:error]= "Email or Password is invalid"
      render "new"
    end
  end


  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url
  end
end
