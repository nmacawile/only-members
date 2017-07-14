class UsersController < ApplicationController
  before_action :signed_in, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Edit success"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    user = User.find(params[:id])
    name = user.name
    user.destroy
    flash[:info] = "User '#{name}' has been deleted."
    redirect_to users_path
  end
 
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def correct_user
      user = User.find(params[:id])
      redirect_to root_path unless current_user?(user)
    end
    
    def admin
      redirect_to root_path unless admin?
    end
    
    def signed_in
      redirect_to signin_path unless signed_in?
    end
end
