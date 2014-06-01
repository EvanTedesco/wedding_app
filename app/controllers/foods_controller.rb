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
    @food = Food.new name: params[:food][:name], description: params[:food][:description]
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
    @food.update name: params[:food][:name], description: params[:food][:description]
    redirect_to foods_path
  end

end
