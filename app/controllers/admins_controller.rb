class AdminsController < ApplicationController

  before_action :confirm_admin
  def index

  end

  def confirm_admin
    redirect_to '/' unless session[:logged_in]
  end
end