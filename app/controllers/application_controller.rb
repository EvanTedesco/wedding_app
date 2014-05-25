class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

private
  def confirm_logged_in
    redirect_to '/' unless session[:user_id]
  end

  def confirm_new_rsvp
    @current_rsvp = Rsvp.find_by user_id: current_user[:id]
    if @current_rsvp
      @current_rsvp[:attending] != nil
      flash[:rsvp_error] = 'A RSVP already exists for you'
      redirect_to '/'
    else
      render :new
    end
  end
end
