class Public::CustomersController < ApplicationController
  before_action :guest_customer, except: [:show]
  def guest_customer
    if current_customer.email == 'guest@example.com'
      redirect_to root_path, notice: "ゲストユーザーは閲覧のみです。"
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end



  def edit
     @customer = Customer.find(params[:id])
  end

  def update
   customer = Customer.find(params[:id])
   customer.update(customer_params)
   redirect_to customer_path(customer)
  end

    def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
    end

  def draft
    # @customer = current_customer
    @posts = current_customer.posts.where(is_draft: true)
  end

  private
  def customer_params
    params.require(:customer).permit(:id, :name, :email, :is_deleted, :introduction, :created_at, :profile_image)
  end
end
