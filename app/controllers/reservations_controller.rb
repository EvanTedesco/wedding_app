class ReservationsController < ApplicationController
  def new
    number_of_rooms = params[:number_of_rooms]
    room_key = "room#{number_of_rooms}".to_sym
    @reservation =Expedia::Api.new.get_availability({
                                                      :hotelId => 193964,
                                                      :SupplierType => 'E',
                                                      :arrivalDate => params[:arrival_date],
                                                      :departureDate => params[:departure_date],
                                                      room_key => params[:number_of_adults],
                                                      :includeDetails => 'true',
                                                      :options => 'ROOM_AMENITIES,ROOM_TYPES',
                                                      :minorRev => 24
                                                    }).body
  end
end