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
      flash[:created] = "#{@user.name} has been sent an invitation"
      redirect_to new_user_path
    else
      render :new
    end
  end

  private
  def secure_params
    params.require(:user).permit(:email, :password, :name)
  end
end
