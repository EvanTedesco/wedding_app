class UsersController < ApplicationController



  def new
    @user = User.new
    @users = User.all
  end

  def create
    password = 'password'
    password_confirmation = 'password'
    auth_token = SecureRandom.urlsafe_base64
    @user = User.new(secure_params.merge({password: password, password_confirmation: password_confirmation, auth_token: auth_token}))
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
    params.require(:user).permit(:email, :name, :max_guests)
  end
end
