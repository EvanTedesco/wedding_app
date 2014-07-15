class RsvpsController < ApplicationController

  before_action :confirm_logged_in


  def index
    @users = User.all
  end

  def new
    @user = User.find current_user.id
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
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @guests = Guest.where(user_id: params[:id])
  end


  def secure_params
    params.require(:rsvp).permit(:attending, :number_of_guests,
                                 :user_food_id, :comments, :user_id, guest: [:name, :food_id])
  end
end
