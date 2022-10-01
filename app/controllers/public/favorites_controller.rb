class Public::FavoritesController < ApplicationController
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
    @favorites = current_customer.favorites
  end

  private
   def favorite_params
   params.require(:favorites).permit(:post_id, :favorites)
   end
end

