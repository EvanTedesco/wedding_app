class SessionController < ApplicationController

  def create
    if params[:password] == ENV['PASSWORD']
      session[:logged_in] = true
    end
    redirect_to root_path
  end
end