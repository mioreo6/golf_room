class Public::HomesController < ApplicationController
  def top
    @posts = Post.order('id DESC').limit(5)
  end

  def about
  end
end
