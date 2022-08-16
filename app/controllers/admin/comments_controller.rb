class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.all
    @comment = Comment.find(params[:id])
    
  end

  def show
  end
  private
  def comment_params
     params.require(:comment).permit(:id, :comment, :created_at, :customer_id)
  end
end
