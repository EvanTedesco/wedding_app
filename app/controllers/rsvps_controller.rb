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
    unless session[:admin]
      confirm_new_rsvp
    end
  end

  def create
    @rsvp = Rsvp.new(secure_params.merge ({user_id: current_user.id}))
    @rsvp.save_fields
    @user = User.find(current_user.id)


    if @rsvp.save_fields
      flash[:partial] =  @user[:attending] ? 'dance' : 'cry'
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
