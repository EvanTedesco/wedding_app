class RsvpsController < ApplicationController

  def index
    @rsvp = Rsvp.all
  end

  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new(
        name: params[:rsvp][:name],
        email: params[:rsvp][:email],
        attending: params[:rsvp][:attending],
        comments: params[:rsvp][:comments]

    )
    if @rsvp.save && @rsvp[:attending] == true
      flash[:partial] = 'dance'
      redirect_to root_path
    elsif
      @rsvp.save && @rsvp[:attending] == false
      flash[:partial] = 'cry'
      redirect_to root_path
      else
      render :new
    end
  end

  #private
  #def allowed_parameters
  #  params.require(:rsvp).permit(:name,:attending,:guest)
  #end
end
