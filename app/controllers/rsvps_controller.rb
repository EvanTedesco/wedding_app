class RsvpsController < ApplicationController

  before_action do
    confirm_logged_in
    @user = User.find(params[:user_id])

  end


  def index
    @rsvp = Rsvp.all
  end


  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new(
        attending: params[:rsvp][:attending],
        comments: params[:rsvp][:comments]
    )
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


end
