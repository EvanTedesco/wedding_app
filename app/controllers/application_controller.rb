class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :total_guests, :build_guest_fields

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def total_guests
    @attending_users = User.where(attending: true)
    @attending_users.size + @attending_users.inject(0) {|acc, user| acc + user.number_of_guests}
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
