class Admin::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(20)
  end

  def show
  end

  private
  def post_params
    params.require(:post).permit(:id, :customer_id, :created_at, :body)
  end
end
