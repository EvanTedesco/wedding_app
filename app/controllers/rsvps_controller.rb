class RsvpsController < ApplicationController

  before_action do
    confirm_logged_in
  end

  def index
    @users = User.all
  end

  def new
    @user = User.find params[:user_id]
    @rsvp = Rsvp.new

    @foods = Food.all
    #unless session[:admin]
    #end
  end

  def create
    @rsvp = Rsvp.new(secure_params.merge ({user_id: current_user.id}))
    @rsvp.save_fields

    if @rsvp.save_fields
      #flash[:partial] = [@attributes][:attending] ? "dance" : "cry"
      redirect_to root_path
    else
      @foods = Food.all

      render :new
    end
  end


  def secure_params
    params.require(:rsvp).permit(:attending, :number_of_guests, :guest_name,
                                 :user_food_id, :guest_food_id, :comments, :user_id)
  end


end
