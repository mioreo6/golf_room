class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @customers = Customer.page(params[:page]).per(20)
  end

  def show
  end

  def edit
  end


  private
  def customer_params
    params.require(:customer).permit(:id, :name, :email, :is_deleted, :introduction, :created_at)
  end
end
