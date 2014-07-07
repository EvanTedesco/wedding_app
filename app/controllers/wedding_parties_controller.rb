class WeddingPartiesController < ApplicationController

  before_action :confirm_logged_in

  def index
    @photos = WeddingParty.all

  end
end
