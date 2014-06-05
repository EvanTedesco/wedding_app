class RsvpsController < ApplicationController

  before_action do
    confirm_logged_in
  end

  def index
    @rsvp = Rsvp.all
  end

  def new
    @rsvp = Rsvp.new
    @rsvp.build_meal_choice
    current_user.max_guests.times do
      @rsvp.guests.build
    end

    @foods = Food.all
    unless session[:admin]
      confirm_new_rsvp
    end
  end

  def create

    @rsvp = current_user.build_rsvp(secure_params)

    if @rsvp.save
      flash[:partial] = @rsvp[:attending] ? "dance" : "cry"
      redirect_to root_path
    else
      @rsvp.build_meal_choice unless @rsvp.meal_choice
      @foods = Food.all
      render :new
    end
  end


def secure_params
  params.require(:rsvp).permit(:attending,:comments,:number_of_guests , meal_choice_attributes: [:food_id], guests_attributes: [:name, :food_id])
end


end
