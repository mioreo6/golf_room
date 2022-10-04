class Public::FavoritesController < ApplicationController
  before_action :guest_customer, except: [:all]
   def guest_customer
    if current_customer.email == 'guest@example.com'
      redirect_to root_path, notice: "ゲストユーザーは閲覧のみです。会員登録をお願いします。"
    end
   end

  def create
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: @post.id)
    favorite.save
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy
    redirect_to post_path(@post)
  end

  def all
    @customer = Customer.find(params[:customer_id])
    @favorites = @customer.favorites.page(params[:page]).per(15)
  end

  private
   def favorite_params
   params.require(:favorites).permit(:post_id, :favorites)
   end
end

