class Admin::OrdersController < ApplicationController
  layout 'admin'
  skip_before_action :verify_authenticity_token
  before_action :set_order, only: %i[ show edit update destroy ]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    d =Time.now.strftime("%Y%m%d")
    @shopping_car = ShoppingCar.all
    @shopping_car.each do |p|
      @order = Order.new()
      @order.p_name = p.p_name
      @order.name = d[2,7] + [*('A'..'Z'),*(0..9)].shuffle[0..7].join
      @order.num = p.p_num
      @order.p_price = p.p_price
      @order.status = "未付款"
      @order.p_addr = params[:address_id]
      @order.save

    end
    redirect_to orders_path
  end

  def update
    if @order.update(order_params)
       redirect_to edit_admin_user_order_path
    end
  end

  def destroy
    @order.destroy
    redirect_to admin_user_orders_path
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :status, :p_name, :p_price, :num, :p_addr)
    end
end
