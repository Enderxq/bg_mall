class Admin::ProductsController < ApplicationController
  layout 'admin'
  skip_before_action :verify_authenticity_token
  skip_before_action :authorized, only: [:index, :show, :create, :set_product]
  before_action :set_product, only: %i[show edit update destroy ]
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new()
    @product.name = params[:product][:name]
    @product.kind_id = params[:product][:kind_id]
#   @product.status = params[:product][:status]
    @product.stock = params[:product][:stock]
    @product.original_price = params[:product][:original_price]
    @product.discounted_price = params[:product][:discounted_price]

    @product.p_num = [*('A'..'Z'),*(0..9)].shuffle[0..9].join

    if @product.save
      redirect_to admin_products_path
    else
      flash[:notice] = "新建商品失败"
      redirect_to new_admin_product_path
    end
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "修改成功"
      redirect_to admin_products_path
    else
      flash[:notice] = "修改失败"
      redirect_to edit_admin_product_path
    end
  end

  def destroy
    @product.destroy

    flash[:notice] = "删除成功"
    redirect_to admin_products_path
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :kind_id, :original_price, :discounted_price, :stock, :pnum)
    end
end
