class Public::PostsController < ApplicationController
  def index
    #@posts = Post.all.search(params[:search])
    # @posts =Post.where(is_draft: :false).all.search(params[:search])
  @posts= Post.all
  @tags = Tag.all
  @posts = @posts.where("body LIKE ? ",'%' + params[:search] + '%') if params[:search].present?
  #もしタグ検索したら、post_idsにタグを持ったidをまとめてそのidで検索
  if params[:tag_ids].present?
    post_ids = []
    params[:tag_ids].each do |key, value|
      if value == "1"
        Tag.find_by(tag_name: tag_ids).posts.each do |p|
          post_ids << p.id
        end
      end
    end
    post_ids = post_ids.uniq
    #キーワードとタグのAND検索
    @posts = @posts.where(id: post_ids) if post_ids.present?
  end


  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id

    @post.is_draft = params[:body].present? ? false : true

    if @post.save
      # 下書き(非公開)の場合
      if @post.is_draft
        redirect_to customer_path(current_customer), notice: "下書き保存しました！"
      # 投稿(公開)の場合
      else
        redirect_to root_path, notice: "投稿しました！"
      end
    else
      render :new
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.customer_id = current_customer.id

   if @post.is_draft == false
    if params[:body]
      @post.save
      redirect_to posts_path
    elsif params[:update_draft]
      @post.update
      redirect_to posts_path(@post)
    end
   else
     if @post.update(post_params)
       redirect_to posts_path
     else
       render :edit
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