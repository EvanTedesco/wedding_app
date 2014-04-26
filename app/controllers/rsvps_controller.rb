class RsvpsController < ApplicationController
  def index
    @rsvp = Rsvp.all
    p @rsvp
  end

  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new(
        name: params[:rsvp][:name],
        attending: params[:rsvp][:attending],
        guest: params[:rsvp][:guest]
    )
    if @rsvp.save
      redirect_to rsvps_path
    else
      render :new
    end
  end

  #private
  #def allowed_parameters
  #  params.require(:rsvp).permit(:name,:attending,:guest)
  #end
end
