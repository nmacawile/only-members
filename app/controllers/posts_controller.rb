class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  def index
    @post = Post.new
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end
  
  def new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = "Post created"
    else
      flash[:danger] = "Posting failed"
    end
    redirect_to root_path
  end
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:info] = "Post has been deleted."
    redirect_to current_user
  end
  
  private
    def post_params
      params.require(:post).permit(:content)
    end
  
    def signed_in_user
      redirect_to signin_path unless signed_in?
    end
    
    def correct_user
      user = Post.find(params[:id]).user
      unless current_user?(user)
        flash[:warning] = "That post is not yours"
        redirect_to root_path
      end
    end
end
