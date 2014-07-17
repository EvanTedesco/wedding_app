class FoodsController < ApplicationController

  before_action do
    confirm_admin
  end

  def index
    @foods =Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(secure_params)
    if @food.save
      redirect_to foods_path
    else
      render :new
    end
  end

  def destroy
    @food = Food.destroy(params[:id])
    redirect_to foods_path
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    @food.update(secure_params)
    redirect_to foods_path
  end

  def secure_params
    params.require(:food).permit(:name,:description)
  end
end
