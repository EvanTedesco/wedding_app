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
    #current_user.max_guests.times do
    #  @rsvp.guest.build
    #end
    @foods = Food.all
    unless session[:admin]
      confirm_new_rsvp
    end
  end

  def create
    @rsvp = Rsvp.new(secure_params.merge({user: current_user}))

    if @rsvp.save
      @meal_choice = MealChoice.new(rsvp_id: @rsvp.id, food_id: params[:rsvp][:meal_choice_attributes][:food_id])
      if @meal_choice.save
        flash[:partial] = @rsvp[:attending] ? "dance" : "cry"
        redirect_to root_path
      end
    else
      @rsvp.build_meal_choice unless @rsvp.meal_choice
      @foods = Food.all
      render :new
    end
  end


def secure_params
  params.require(:rsvp).permit(:attending, :comments, :number_of_guests, :user_id)
end


end
