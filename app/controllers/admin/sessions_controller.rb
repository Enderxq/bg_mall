class Admin::SessionsController < ApplicationController
  layout 'admin'
  skip_before_action :verify_authenticity_token
  skip_before_action :authorized, only: [:new, :create, :welcome, :destroy]

  def new
    flash[:notice] = "请以管理员身份登录"
  end

  def create
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
