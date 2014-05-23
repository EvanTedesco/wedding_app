class UsersController < ApplicationController

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(secure_params)
    if @user.save

      redirect_to root_path
    else
      render :new
    end
  end

  private
  def secure_params
    params.require(:user).permit(:email, :password)
  end
end
