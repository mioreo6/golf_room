class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!,except: [:index]
  before_action :guest_customer, except: [:index, :show]
  
  def guest_customer
    if current_customer.email == 'guest@example.com'
      redirect_to root_path, notice: "ゲストユーザーは閲覧のみです。"
    end
  end
  
  def index
    @post = Post.find(params[:post_id])
  end

  def all
    @post = current_customer.comment
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
