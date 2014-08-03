require 'spec_helper'

describe Reservation do
  it 'gets the descriptions for the available rooms' do
    new_time = '2014-07-11T21:53:58Z'
    Timecop.freeze(new_time) do
      VCR.use_cassette('models/deets') do
        request = Expedia::Api.new.get_availability({
                                                      :hotelId => 193964,
                                                      :SupplierType => 'E',
                                                      :arrivalDate => "04/04/2015",
                                                      :departureDate => "04/11/2015",
                                                      :room_key => "2",
                                                      :includeDetails => 'true',
                                                      :options => 'ROOM_AMENITIES,ROOM_TYPES',
                                                      :minorRev => 24

                                                    }).body

        expect(Reservation.new(request).get_descriptions).to eq(["Two Doubles",
                                                "Two Double Beds, Ocean Front, Non-Smoking",
                                                "One Double Bed, Garden View, Non-Smoking",
                                                "King Garden View",
                                                "Two Double Beds, Garden View, Smoking",
                                                "Two Doubles with balcony",
                                                "Two Double Beds, Non-Smoking, Accessible",
                                                "King Balcony",
                                                "Two Doubles/balcony/smoking",
                                                "One King Bed, Non-Smoking, Accessible",
                                                "1 Queen jt ste gndvw N/S",
                                                "One King Bed, Smoking",
                                                "Junior Suite, One King Bed, Non-Smoking"])
      end
    end
  end
end