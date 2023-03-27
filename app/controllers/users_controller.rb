class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  skip_before_action :verify_authenticity_token, :only => [:create, :change_pwd]

  def new
    @user = User.new
  end

  def create
    if params[:user][:phone].nil? && !params[:user][:email].nil?
      @user = User.find_by(email: params[:user][:email])
    elsif !params[:user][:phone].nil? && params[:user][:email].nil?
      @user = User.find_by(phone: params[:user][:phone])
    end
    if @user.nil?
      if params[:user][:password] == params[:user][:password_confirmation]
        @user = User.create(params.require(:user).permit(:username, :email, :phone, :password))
        Rails.logger.info @user.id.to_s + " : " + @user.password
        session[:user_id] = @user.id
        redirect_to '/sessions/new'
      else
      flash[:notice] = "密码不一致"
      redirect_to new_user_path
      end
    else
      flash[:notice] = "用户已存在"
      redirect_to new_user_path
    end
  end

  def change_pwd
    @user = User.find_by(id: session[:user_id])
    if !@user.authenticate(params[:old_password])
        flash[:notice] = "旧密码不正确"
    elsif params[:password] == params[:password_confirmation]
         @user.password = params[:password]
         @user.save
         flash[:notice] = "密码修改成功"
    else
         flash[:notice] = "密码不一致"
    end
  end

  def show
  end
end
