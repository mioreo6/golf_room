class Public::CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])

  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.customer_id = current_customer.id
    @comment.post_id = post.id
    @comment.save
    redirect_to '/posts'
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

  end

  private
   def comment_params
   params.require(:comment).permit(:comment, :post_id)
   end
end
