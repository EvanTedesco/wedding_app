class UsersController < ApplicationController



  def new
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.new(secure_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      flash[:created] = "#{@user.name} has been sent an invitation"
      redirect_to new_user_path
    else
      @users = User.all
      render :new
    end
  end

  private
  def secure_params
    params.require(:user).permit(:email, :password, :name)
  end
end
