class ReservationsController < ApplicationController
  def new
    @reservation = Expedia::Api.new.get_list({:propertyName => 'Doubletree',
                                              :destinationString => 'puntarenas',
                                              :arrivalDate => params[:arrival_date],
                                              :departureDate => params[:departure_date],
                                              :include_details => true,
                                              :room1 => '2'}).body

  end
end