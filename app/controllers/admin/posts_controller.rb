class Admin::PostsController < ApplicationController
 before_action :authenticate_admin!
  def index
    @posts = Post.page(params[:page]).per(15)
  end

  def all
   @customer = Customer.find(params[:customer_id])
   @posts = @customer.posts.where(is_draft: false).page(params[:page]).per(15)
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
