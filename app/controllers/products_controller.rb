class ProductsController < ApplicationController
  def index
    @products = if params[:products]
      Product
        .filter_by_title_price(products_params[:title], products_params[:min], products_params[:max])
    else
      Product.sort_by_title_price
    end
  end

  def show
    @product = Product.find(params[:id])
    @order = current_order.nil? ? Order.new : current_order
    @order.line_items.build
  end

  private

  def products_params
    params.require(:products).permit(:title, :min, :max)
  end
end
