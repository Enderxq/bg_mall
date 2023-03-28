class Admin::KindsController < ApplicationController
  layout 'admin'
  skip_before_action :verify_authenticity_token
  skip_before_action :authorized, only: [:create, :index, :show]
  before_action :set_kind, only: %i[ show edit update destroy ]

  def index
    @kinds = Kind.all
  end

  def show
  end

  def new
    @kind = Kind.new
  end

  def edit
  end

  def create
    @kind = Kind.new()

    @kind.name = params[:kind][:name]
 #  @kind.weight = params[:kind][:weight]
    @kind.category_id = params[:category_id]

    if @kind.save
      redirect_to admin_category_kinds_path
    else
      redirect_to new_admin_category_kind_path
    end
  end

  def update
    @kind.name = params[:kind][:name]
 #  @kind.weight = params[:kind][:weight]
    @kind.category_id = params[:category][:id]

    if @kind.save
      redirect_to admin_category_kinds_path
    else
      redirect_to edit_admin_category_kind_path
    end
  end

  def destroy
    @kind.destroy
    redirect_to admin_category_kinds_path
  end

  private
    def set_kind
      @kind = Kind.find(params[:id])
    end

    def kind_params
      params.require(:kind).permit(:name, :category_id)
    end
end
