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

        expect(Reservation.new(request).get_room_info).to eq({
                                                               "Two Doubles" => {:average_rate => "198.0"},
                                                               "Two Double Beds, Ocean Front, Non-Smoking" => {:average_rate => "198.0"},
                                                               "One Double Bed, Garden View, Non-Smoking" => {:average_rate => "198.0"},
                                                               "King Garden View" => {:average_rate => "198.0"},
                                                               "Two Double Beds, Garden View, Smoking" => {:average_rate => "198.0"},
                                                               "Two Doubles with balcony" => {:average_rate => "228.0"},
                                                               "Two Double Beds, Non-Smoking, Accessible" => {:average_rate => "228.0"},
                                                               "King Balcony" => {:average_rate => "228.0"},
                                                               "Two Doubles/balcony/smoking" => {:average_rate => "228.0"},
                                                               "One King Bed, Non-Smoking, Accessible" => {:average_rate => "228.0"},
                                                               "1 Queen jt ste gndvw N/S" => {:average_rate => "228.0"},
                                                               "One King Bed, Smoking" => {:average_rate => "228.0"},
                                                               "Junior Suite, One King Bed, Non-Smoking" => {:average_rate => "249.0"}
                                                             })
      end
    end
  end
end