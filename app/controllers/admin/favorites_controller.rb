class Admin::FavoritesController < ApplicationController
  before_action :authenticate_admin!
  def index
  end

  def all
    @customer = Customer.find(params[:customer_id])
    @favorites = @customer.favorites
  end
end
