class Admin::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorized, only: [:new, :create, :welcome, :destroy]

  def new
    flash[:notice] = "请以管理员身份登录"
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.nil? then
     @user = User.find_by(phone: params[:phone])
    end

    if @user && @user.authenticate(params[:password])
      Rails.logger.info  "admin: " + @user.Is_admin
      if @user.Is_admin = true
         session[:user_id] = @user.id
#        Rails.logger.info "--------------:" + session[:user_id].to_s
         session[:user_email] = @user.email
         session[:user_phone] = @user.phone
         flash[:notice] = "登录成功"
         @shopping_cars = ShoppingCar.where(user_id: nil)
         if !@shopping_cars.nil?
            @shopping_cars.each do |shopping_car|
              shopping_car.user_id = @user.id
              shopping_car.save
            end
         end
         redirect_to '/welcome'
      else
        flash[:notice] = "该用户不是管理员"
      end
    else
       flash[:notice] = "密码错误，请重新输入！"
       redirect_to new_session_path
    end
  end

  def welcome
  end

  def destroy
    session[:user_id] = nil
    session[:user_email] = nil
    session[:user_phone] = nil
    flash[:notice] = "退出成功"
    redirect_to '/sessions/new'
  end

  def page_requires_login
  end
end
