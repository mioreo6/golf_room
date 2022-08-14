class Public::PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to root_path
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:body, :id, :created_at)
  end
end
