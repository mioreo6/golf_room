class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
   @post = Post.find(params[:post_id])
  end

  def all
    @customer = Customer.find(params[:customer_id])
    @post = @customer.comment.page(params[:page]).per(15)
  end

  def show
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_posts_path
  end

  private
  def comment_params
     params.require(:comment).permit(:id, :comment, :created_at, :customer_id, :post_id)
  end
end
