class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorized, only: [:new, :create, :welcome, :destroy]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.nil? then
     @user = User.find_by(phone: params[:phone])
    end

    Rails.logger.info  "admin: " + @user.is_admin.to_s
    if @user && @user.authenticate(params[:password])
      if params[:ID] == "admin" && @user.is_admin 
         session[:user_is_admin] = @user.is_admin
      elsif params[:ID] == "admin" && !@user.is_admin
        flash[:notice] = "该用户没有管理员权限！"
        redirect_to new_session_path
      end
      session[:user_id] = @user.id
#      Rails.logger.info "--------------:" + session[:user_id].to_s    
      session[:user_email] = @user.email
      session[:user_phone] = @user.phone
      @shopping_cars = ShoppingCar.where(user_id: nil)
      if !@shopping_cars.nil?
        @shopping_cars.each do |shopping_car|
          shopping_car.user_id = @user.id
          shopping_car.save
        end
      end
      flash[:notice] = "登录成功"
      redirect_to '/welcome'
    else
      flash[:notice] = "密码或者邮箱错误，请重试！"
      redirect_to new_session_path
    end
  end

  def welcome
  end

  def destroy
    session[:user_id] = nil
    session[:user_email] = nil
    session[:user_phone] = nil
    session[:user_is_admin] = nil
    flash[:notice] = "退出成功"
    redirect_to '/sessions/new'
  end

  def page_requires_login
  end
end
