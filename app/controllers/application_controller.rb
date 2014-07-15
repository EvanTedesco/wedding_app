class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :total_guests, :build_guest_fields

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def total_guests
    @users = User.all
    guest_count = 0
    @users.each do |user|
      if user.attending
        guest_count += 1
        guest_count += user.number_of_guests
      end
    end
    guest_count
  end

  def build_guest_fields
    current_user.max_guests.times do
      @user.guests.build
    end
  end



private
  def confirm_admin
    redirect_to '/' unless current_user.admin?

  end

  def confirm_logged_in
    if !current_user
      redirect_to '/sessions/new'
      flash[:login_failure] = 'You must be logged in to see this page'
      session[:return_path] = request.original_url
    end
  end

  def confirm_new_rsvp
    if current_user.attending?
      flash[:rsvp_error] = 'A RSVP already exists for you'
      redirect_to '/'
    else
      render :new
    end
  end


end
