class PhotosController < ApplicationController

  before_action do
    confirm_logged_in
  end
  
  def index
    @photos = Photo.all
  end
end