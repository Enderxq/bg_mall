class ShoppingCarController < ApplicationController
  skip_before_action :authorized
  skip_before_action :verify_authenticity_token
  before_action :set_shopping_car, only: %i[show edit update destroy ]

  def index
      @shopping_cars = ShoppingCar.where(user_id: session[:user_id])
  end

  def new
    @product = Product.find(params[:id])
    @shopping_car = ShoppingCar.where(user_id: session[:user_id]).find_by(p_name: @product.name)

    if @shopping_car.nil?
      @shopping_car = ShoppingCar.new()
      @shopping_car.user_id = session[:user_id]
       @shopping_car.p_name = @product.name
       @shopping_car.p_num = 1
       @shopping_car.p_price = @shopping_car.p_num * @product.discounted_price.to_i
    else
       @shopping_car.p_name = @product.name
       @shopping_car.p_num = @shopping_car.p_num + 1
       @shopping_car.p_price = @shopping_car.p_num * @product.discounted_price.to_i
    end

    if !session[:user_id].nil?
       @shopping_car.user_id = session[:user_id]
    end
#    Rails.logger.info "shopping_car.user_id" + session[:user_idi].to_s
    @shopping_car.save
#    Rails.logger.info @shopping_car.errors.full_messages
    redirect_to shopping_car_index_path
  end

  def create
    @shopping_car = ShoppingCar.find_by(params[:id])
    @product = Product.find_by(params[:id])

    if @shopping_car.nil? 
       @shopping_car = ShoppingCar.new()
       @shopping_car.p_name = @product.name
       @shopping_car.p_num = 0
       @shopping_car.p_price = 0
    end

    @shopping_car.save
  end

  def show
  end

  def update
    @product = Product.find_by(name: @shopping_car.p_name)

    @shopping_car.p_num = params[:amount]
    @shopping_car.p_price = @shopping_car.p_num * @product.discounted_price.to_i

    @shopping_car.save
   # Rails.logger.info params[:amount]
    redirect_to shopping_car_index_path
  end

  def destroy
    if @shopping_car.destroy
      redirect_to shopping_car_index_path
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopping_car
      @shopping_car = ShoppingCar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shopping_car_params
      params.require(:shopping_car).permit(:p_name, :p_num, :p_price, :user_id)
    end
end
