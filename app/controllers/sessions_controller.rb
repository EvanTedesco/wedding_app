class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by email: params[:user][:email]
    if @user.present? && @user.authenticate(params[:user][:password])
      session[:user_id] = @user[:id]
      flash[:success] = "Welcome #{@user[:name]}"
      redirect_to session[:return_path] || root_path
    else
      @user = User.new
      flash[:login_failure] = 'Incorrect Email or Password'
      render new_session_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end