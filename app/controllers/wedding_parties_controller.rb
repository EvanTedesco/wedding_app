class WeddingPartiesController < ApplicationController

  def index
    @photos = WeddingParty.all

  end
end
