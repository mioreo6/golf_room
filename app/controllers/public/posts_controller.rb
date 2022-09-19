class Public::PostsController < ApplicationController
  def index
    #@posts = Post.all.search(params[:search])
    @posts = Post.where(is_draft: :false).all.search(params[:search])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id

    # if params[:body].present?
    #   @post.is_draft = false
    # else
    #   @post.is_draft = true
    # end

    @post.is_draft = params[:body].present? ? false : true

    if @post.save
      if @post.is_draft
        redirect_to customer_path(current_customer), notice: "下書き保存しました！"
      else
        redirect_to root_path, notice: "投稿しました！"
      end
    else
      render :new
    end

    # # 投稿ボタン
    # if params[:post]
    #   if @post.save
    #     redirect_to root_path, notice: "投稿しました！"
    #   else
    #     @post = Post.new(post_params)
    #     @post.customer_id = current_customer.id
    #     @post.save
    #     render :new, alert: "投稿できませんでした。再度投稿してください。"
    #   end
    # # 下書きボタン
    # else
    #   if @post.update(is_draft: false)
    #     redirect_to customer_path(current_customer), notice: "下書き保存しました！"
    #   else
    #     @post = Post.new(post_params)
    #     @post.customer_id = current_customer.id
    #     @post.save
    #     render :new, alert: "保存できませんでした。"
    #   end
    # end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

        # ①下書きを投稿（公開）
    if params[:publicize_draft]
       @post.attributes = post_params.merge(is_draft: false)
      if @post.save
        redirect_to root_path, notice: "下書きのレシピを公開しました！"
      else
        @post.is_draft = true
        render :edit, alert: "公開できませんでした。再度お試しください"
      end
    # 投稿したものを更新
    elsif params[:update_post]
      @post_recipe.attributes = post_recipe_params
      if @post_recipe.save
        redirect_to root_path, notice: "レシピを更新しました！"
      else
        render :edit, alert: "レシピを更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 下書きを更新
    else
      if @post.update(post_params)
        redirect_to root_path, notice: "下書きレシピを更新しました！"
      else
        render :edit, alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end



  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:body, :id, :created_at, :customer_id, :is_draft, tag_ids: [])
  end
end