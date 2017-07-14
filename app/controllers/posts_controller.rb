class PostsController < ApplicationController
  before_action :signed_in_user, only: :destroy
  before_action :correct_user, only: :destroy
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:info] = "Post has been deleted."
    redirect_to current_user
  end
  
  private
  
    def signed_in_user
      redirect_to signin_path unless signed_in?
    end
    
    def correct_user
      user = Post.find(params[:id]).user
      flash[:warning] = "That post is not yours"
      redirect_to root_path unless current_user?(user)
    end
end
