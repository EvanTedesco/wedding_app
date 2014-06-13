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

    build_guest_fields

    unless session[:admin]
      confirm_new_rsvp
    end
  end

  def create
    @rsvp = Rsvp.new(secure_params.merge ({user_id: current_user.id, guests: params[:guest]}))

    if @rsvp.save_fields
      flash[:partial] = current_user.reload.attending ? 'dance' : 'cry'
      redirect_to root_path
    else
      @foods = Food.all
      @user = current_user

      render :new
    end
  end


  def secure_params
    params.require(:rsvp).permit(:attending, :number_of_guests,
                                 :user_food_id, :comments, :user_id, guest: [:name, :food_id])
  end
end
