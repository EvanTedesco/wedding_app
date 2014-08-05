class Reservation
  def initialize(request)
    @request = request
  end

  def get_room_info
    info = {}
    @request["HotelRoomAvailabilityResponse"]["HotelRoomResponse"].each do |room|

      info[room["rateDescription"]] = {
        average_rate: get_average_rate(room),
        total_cost: get_total_cost(room),
        room_type_code: get_room_type_code(room),
        description: get_description(room),
        amenities: get_amenities(room),
        smoking_preference: get_smoking_preference(room) ,
        rate_key: get_rate_key(room),
        rate_code: get_rate_code(room),
      }
    end
    info
  end

  def get_amenities(room)
    amenities = room["RoomType"]["roomAmenities"]["RoomAmenity"].map do |amenity|
      amenity["amenity"]
    end
    amenities
  end

  def get_average_rate(room)
    room["RateInfos"]["RateInfo"]["ChargeableRateInfo"]["@averageRate"]
  end

  def get_total_cost(room)
    room["RateInfos"]["RateInfo"]["ChargeableRateInfo"]["@total"]
  end

  def get_room_type_code(room)
    room["RoomType"]["@roomCode"]
  end

  def get_description(room)
    room["RoomType"]["descriptionLong"]
  end

  def get_smoking_preference(room)
    room["smokingPreferences"]
  end

  def get_rate_key(room)
    room["RateInfos"]["RateInfo"]["RoomGroup"]["Room"]["rateKey"]
  end

  def get_rate_code(room)
    room["rateCode"]
  end
end