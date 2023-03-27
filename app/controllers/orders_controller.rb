class OrdersController < ApplicationController
   skip_before_action :verify_authenticity_token
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
#    @order = Order.new()
    d =Time.now.strftime("%Y%m%d")

    @shopping_car = ShoppingCar.all
    @shopping_car.each do |p|
      @order = Order.new()
    #  @order.name = d.year.to_s + d.month.to_s + d.day.to_s
      @order.p_name = p.p_name
      @order.name = d[2,7] + [*('A'..'Z'),*(0..9)].shuffle[0..7].join
      @order.num = p.p_num
      @order.p_price = p.p_price
      @order.status = "未付款"
      @order.p_addr = params[:address_id]
      @order.save

      p.destroy
    end
    redirect_to orders_path

  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :status, :p_name, :p_price, :num, :p_addr)
    end
end
