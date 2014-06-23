class StoriesController < ApplicationController

  before_action do
  confirm_logged_in
  end

  def index
  end
end