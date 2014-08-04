class Reservation
  def initialize(request)
    @request = request
  end

  def get_room_info
    info = {}
    @request["HotelRoomAvailabilityResponse"]["HotelRoomResponse"].each do |room|

      info[room["rateDescription"]] = {
        average_rate: room["RateInfos"]["RateInfo"]["ChargeableRateInfo"]["@averageRate"],
        total_cost: room["RateInfos"]["RateInfo"]["ChargeableRateInfo"]["@total"],
        room_type_code: room["RoomType"]["@roomCode"],
        rate_key: room["RateInfos"]["RateInfo"]["RoomGroup"]["Room"]["rateKey"],
        rate_code: room["rateCode"],
      }
    end
    info
  end
end