class PostsController < ApplicationController
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:info] = "Post has been deleted."
    redirect_to current_user
  end
end
