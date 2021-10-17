class Admin::DashboardController < ApplicationController
  def show
    @product_counts = Product.count
    @categories_counts = Category.count
  end
end
