class Admin::FavoritesController < ApplicationController
  def index
  end

  def all
    @customer = Customer.find(params[:customer_id])
    @favorites = @customer.favorites
  end
end
