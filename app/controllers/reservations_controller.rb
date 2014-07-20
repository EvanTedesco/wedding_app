class ReservationsController < ApplicationController
  def new
    @reservation = Expedia::Api.new.get_list({:propertyName => 'Doubletree',
                                              :destinationString => 'puntarenas',
                                              :arrivalDate => params[:arrival_date],
                                              :departureDate => params[:departure_date],
                                              :RoomGroup =>"&room6=12,5,12"}).body

  end
end