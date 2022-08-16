class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.all
    @comment = Comment.find(params[:id])

  end

  def show
    @comment = Comment.find(params[:id])
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_post_path(post.id)
  end
  
  private
  def comment_params
     params.require(:comment).permit(:id, :comment, :created_at, :customer_id)
  end
end
