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
        number_of_guests: params[:rsvp][:number_of_guests],
        user: current_user)


    if @rsvp.save
      flash[:partial] =  @rsvp[:attending] ? "dance" : "cry"
      redirect_to root_path
    else
      render :new
    end
  end


end
