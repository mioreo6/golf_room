class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  private
  def post_params
    params.require(:post).permit(:id, :customer_id, :created_at, :body)
  end
end
