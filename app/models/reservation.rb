class Reservation
  def initialize(request)
    @request = request
  end

  def get_room_info
    info = {}
    @request["HotelRoomAvailabilityResponse"]["HotelRoomResponse"].each do |room|
      info[room["rateDescription"]] = {average_rate: room["RateInfos"]["RateInfo"]["ChargeableRateInfo"]["@averageRate"]}
    end
    info
  end
end