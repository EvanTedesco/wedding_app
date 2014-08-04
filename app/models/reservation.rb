class Reservation
  def initialize(request)
    @request = request
  end

  def get_room_info
    info = {}
    @request["HotelRoomAvailabilityResponse"]["HotelRoomResponse"].each do |room|
      amenities = room["RoomType"]["roomAmenities"]["RoomAmenity"].map do |amenity|
        amenity["amenity"]
      end
      info[room["rateDescription"]] = {
        average_rate: room["RateInfos"]["RateInfo"]["ChargeableRateInfo"]["@averageRate"],
        total_cost: room["RateInfos"]["RateInfo"]["ChargeableRateInfo"]["@total"],
        room_type_code: room["RoomType"]["@roomCode"],
        description: room["RoomType"]["descriptionLong"],
        amenities: amenities,
        smoking_preference: room["smokingPreferences"],
        rate_key: room["RateInfos"]["RateInfo"]["RoomGroup"]["Room"]["rateKey"],
        rate_code: room["rateCode"],
      }
    end
    info
  end
end