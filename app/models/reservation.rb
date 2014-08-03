class Reservation
  def initialize(request)
    @request = request
  end

  def get_descriptions
    descriptions = []
    @request["HotelRoomAvailabilityResponse"]["HotelRoomResponse"].each { |d| descriptions << d["rateDescription"] }
    @descriptions =descriptions
  end
end