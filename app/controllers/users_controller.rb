class UsersController < ApplicationController
  def index
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def edit
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Registration success"
      redirect_to @user
    else
      render :new
    end
  end
  
  def update
  end
 
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
