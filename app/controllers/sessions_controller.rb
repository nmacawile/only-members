class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email])
    remember_param = true if params[:session][:remember_me] == "1"
    if @user && @user.authenticate(params[:session][:password])
      sign_in(@user)
      remember_param ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = "Invalid login details"
      render :new
    end
  end
  
  def destroy
    sign_out if signed_in?
    flash[:info] = "You have been logged out."
    redirect_to root_path
  end
end
