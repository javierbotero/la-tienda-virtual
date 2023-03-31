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
    @order = current_order.nil? ? Order.new(user: current_user) : current_order
    @line_items = if @order.new_record?
      [LineItem.new(product: @product)]
    elsif line_items = @order.line_items.select{ |li| li.product_id == @product.id }
      line_items.empty? ? @order.line_items.build(product: @product) : line_items.first
    end
  end

  private

  def products_params
    params.require(:products).permit(:title, :min, :max)
  end
end
