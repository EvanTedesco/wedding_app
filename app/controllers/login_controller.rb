class LoginController < ApplicationController

  def create
    if params[:password] == ENV['PASSWORD']
      session[:logged_in] = true
      redirect_to root_path

    else
      flash[:login_error] = 'Your password is not valid'
      render :new
    end
  end
end