class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  skip_before_action :verify_authenticity_token, :only => :create

  def new
    @user = User.new
  end

  def create

    @user = User.create(params.require(:user).permit(:username, :email, :phone, :password))
    session[:user_id] = @user.id
    redirect_to '/login'
  end
end
