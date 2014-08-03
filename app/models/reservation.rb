class Reservation
  def initialize(request)
    @request = request
  end

  def get_descriptions
    descriptions = []
    @request["HotelRoomAvailabilityResponse"]["HotelRoomResponse"].each do |room|
      descriptions << room["rateDescription"]
    end
    descriptions
  end


  def get_avg_per_night
    averages = []
    @request["HotelRoomAvailabilityResponse"]["HotelRoomResponse"].each do |room|
      averages << room["RateInfos"]["RateInfo"]["ChargeableRateInfo"]["@averageRate"]
    end
    averages
  end
end