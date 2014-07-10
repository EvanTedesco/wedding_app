class UsersController < ApplicationController


  def new
    @user = User.new
    @users = User.all
  end

  def create

    @user = User.new(secure_params.merge(user_defaults))
    if @user.save
      EmailJob.new.async.perform(@user)
      flash[:created] = "#{@user.name} has been sent an invitation"
      redirect_to new_user_path
    else
      @users = User.all
      render :new
    end
  end



def destroy
  @user = User.destroy(params[:id])
  redirect_to new_user_path
end

  private
  def secure_params
    params.require(:user).permit(:email, :name, :max_guests)
  end

  def user_defaults
    {
      password: 'password',
      password_confirmation: 'password',
      auth_token: SecureRandom.urlsafe_base64
    }
  end
end
