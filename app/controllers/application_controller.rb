class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :total_guests

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def total_guests
    @rsvps = Rsvp.all
    guest_count = 0
    @rsvps.each do |rsvp|
      if rsvp.attending
        guest_count += 1
        guest_count += rsvp.number_of_guests
      end
    end
    guest_count
  end



private
  def confirm_admin
    redirect_to '/' unless session[:admin]

  end

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
