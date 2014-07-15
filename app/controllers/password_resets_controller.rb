class PasswordResetsController < ApplicationController
  def new
    token = params[:auth_token]
    @user = User.find_by_auth_token(token)
  end

  def update
    email = params[:user][:email]
    @user = User.find_by_email(email)

    if @user.update_attributes(password: params[:user][:password].presence, password_confirmation: params[:user][:password_confirmation].presence)
      flash[:success] = "Password Successfully saved"
      session[:user_id] = @user[:id]
      redirect_to new_user_rsvp_path(@user)
    else
      render :new
    end
  end
end