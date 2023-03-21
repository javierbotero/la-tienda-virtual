class OrdersController < ApplicationController
  def create
    @order = current_user.orders.build(order_params)

    respond_to do |format|
      if @order.save
        session[:order_id] = @order.id
        format.json do
          render json: { success: true, order_id: @order.id },
                 status: :created
        end
      else
        format.json do
          render json: { success: false, errors: @order.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @order = current_user.orders.find(params[:id])

    respond_to do |format|
      if @order.update(order_params)
        format.json { render json: { success: true, order: @order }, status: :ok }
      else
        format.json { render json: { success: false, error: @order.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def show
  end

  def edit
  end

  private

  def order_params
    params.require(:order).
      permit(:status, line_items_attributes: [:product_id, :quantity])
  end
end
