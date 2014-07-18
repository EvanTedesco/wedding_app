class ReservationsController < ApplicationController
  def index
    api = Expedia::Api.new
    @response = api.get_list({:propertyName => 'Doubletree', :destinationString => 'puntarenas',:arrivalDate => "10/10/2014", :departureDate => "10/12/2014",:RoomGroup =>"&room2=2,5,12"}).body


  end
end