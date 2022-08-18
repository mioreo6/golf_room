class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.customer_id = current_customer.id
    
    post.save
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:body, :id, :created_at, :customer_id, tag_ids: [])
  end
end
