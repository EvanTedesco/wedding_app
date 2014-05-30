class FoodsController < ApplicationController

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
end
