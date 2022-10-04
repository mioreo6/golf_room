class Public::PostsController < ApplicationController
  before_action :authenticate_customer!,except: [:index]
  before_action :guest_customer, except: [:index, :show, :all]

  def guest_customer
    if current_customer.email == 'guest@example.com'
      redirect_to root_path, notice: "ゲストユーザーは閲覧のみです。"
    end
  end

  def index
    #@posts = Post.all.search(params[:search])
    # @posts =Post.where(is_draft: :false).all.search(params[:search])

   @tags = Tag.all
   if params[:tag_id].present?
     if params[:search].present?
        @posts = Tag.find(params[:tag_id]).search(params[:search]).page(params[:page]).per(5)
     else
      @posts = Tag.find(params[:tag_id]).posts.page(params[:page]).per(5)
     end
   elsif params[:search].present?
       @posts = Post.where(is_draft: :false).page(params[:page]).per(5).search(params[:search])
   else
      @posts = Post.page(params[:page]).per(5).where(is_draft: :false)
   end
  end

 def all
  @customer = Customer.find(params[:customer_id])
  @posts = @customer.posts.where(is_draft: false).page(params[:page]).per(15)
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
        redirect_to customer_draft_path(current_customer), notice: "下書き保存しました！"
      # 投稿(公開)の場合
      else
        redirect_to posts_path, notice: "投稿しました！"
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

   if @post.is_draft == true
    if params[:body] #下書き（非公開）→投稿（公開）
      @post.is_draft = false
      @post.save
      redirect_to posts_path
    elsif params[:update_draft] #下書き（非公開）のまま更新
      @post.update
      redirect_to posts_path(@post)
    end
   else
     if @post.update(post_params) #投稿の更新
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