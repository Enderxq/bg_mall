class Admin::CategoriesController < ApplicationController
  layout 'admin'
  skip_before_action :verify_authenticity_token
  skip_before_action :authorized
  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create  
    Rails.logger.info "params[:category][:id]" + params[:category][:id].to_s
    if params[:category][:id] == "" && Category.where(name: params[:category][:name]) == nil
         @category = Category.new()
         @category.name = params[:category][:name]
 #       @category.weight = params[:category][:weight]
          @category.save
    elsif params[:category][:id] != "" && Category.find(params[:category][:id]).kinds.where(name: params[:category][:name]) == nil
         Category.find(params[:category][:id]).kinds.create(name: params[:category][:name],
                             category_id: params[:category][:id])
    else
        flash[:notice] = "该分类已存在"
    end
    redirect_to admin_categories_path
  end

  def update
    @category.update

    redirect_to admin_categories_path
  end

  def destroy
    @category.destroy

    redirect_to admin_categories_path 
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
