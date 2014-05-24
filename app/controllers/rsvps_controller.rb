class RsvpsController < ApplicationController

  before_action do
    confirm_logged_in

  end


  def index
    @rsvp = Rsvp.all
  end


  def new
    @rsvp = Rsvp.new
    unless session[:admin]
      confirm_new_rsvp
    end
  end

  def create
    @rsvp = Rsvp.new(
        attending: params[:rsvp][:attending],
        comments: params[:rsvp][:comments],
        user: current_user)

    if @rsvp.save && @rsvp[:attending] == true
      flash[:partial] = 'dance'
      redirect_to root_path

    elsif @rsvp.save && @rsvp[:attending] == false
      flash[:partial] = 'cry'
      redirect_to root_path
    else
      render :new
    end
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
