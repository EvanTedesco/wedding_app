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
                                                      :includeRoomImages => 'true',
                                                      :options => 'ROOM_AMENITIES,ROOM_TYPES',
                                                      :minorRev => 24

                                                    }).body

        expect(Reservation.new(request).get_room_info).to eq({
                                                               "Two Doubles"=>
                                                                {:average_rate=>"198.0",
                                                                 :total_cost=>"1386.0",
                                                                 :room_type_code=>"223811",
                                                                 :rate_key=>"9a257344-c6a8-4f9b-bd1d-3ab51d92c1c9",
                                                                 :rate_code=>545532},
                                                               "Two Double Beds, Ocean Front, Non-Smoking"=>
                                                                 {:average_rate=>"198.0",
                                                                  :total_cost=>"1386.0",
                                                                  :room_type_code=>"200266952",
                                                                  :rate_key=>"791c7991-f665-4ee7-a541-81273e13f676",
                                                                  :rate_code=>201572162},
                                                               "One Double Bed, Garden View, Non-Smoking"=>
                                                                 {:average_rate=>"198.0",
                                                                  :total_cost=>"1386.0",
                                                                  :room_type_code=>"200266962",
                                                                  :rate_key=>"f268f807-6665-4376-892a-966e7aec8fa7",
                                                                  :rate_code=>201572210},
                                                               "King Garden View"=>
                                                                 {:average_rate=>"198.0",
                                                                  :total_cost=>"1386.0",
                                                                  :room_type_code=>"223817",
                                                                  :rate_key=>"4347b69a-786c-419e-a7bd-8fdc151da44f",
                                                                  :rate_code=>545548},
                                                               "Two Double Beds, Garden View, Smoking"=>
                                                                 {:average_rate=>"198.0",
                                                                  :total_cost=>"1386.0",
                                                                  :room_type_code=>"200266981",
                                                                  :rate_key=>"eec59358-6174-4822-bca1-472f717b8617",
                                                                  :rate_code=>201572327},
                                                               "Two Doubles with balcony"=>
                                                                 {:average_rate=>"228.0",
                                                                  :total_cost=>"1596.0",
                                                                  :room_type_code=>"223815",
                                                                  :rate_key=>"d6e93fba-b3ce-41ef-b1fc-e5dcc4997e86",
                                                                  :rate_code=>545543},
                                                               "Two Double Beds, Non-Smoking, Accessible"=>
                                                                 {:average_rate=>"228.0",
                                                                  :total_cost=>"1596.0",
                                                                  :room_type_code=>"200266967",
                                                                  :rate_key=>"ea89872d-72cb-43d8-a28e-2f03d105f4a5",
                                                                  :rate_code=>201572251},
                                                               "King Balcony"=>
                                                                 {:average_rate=>"228.0",
                                                                  :total_cost=>"1596.0",
                                                                  :room_type_code=>"223819",
                                                                  :rate_key=>"55468fe4-167a-4412-9530-9d98ffb06f6c",
                                                                  :rate_code=>545554},
                                                               "Two Doubles/balcony/smoking"=>
                                                                 {:average_rate=>"228.0",
                                                                  :total_cost=>"1596.0",
                                                                  :room_type_code=>"223821",
                                                                  :rate_key=>"93e941a4-c89c-471b-b8f3-09f6d59554b4",
                                                                  :rate_code=>545563},
                                                               "One King Bed, Non-Smoking, Accessible"=>
                                                                 {:average_rate=>"228.0",
                                                                  :total_cost=>"1596.0",
                                                                  :room_type_code=>"200266974",
                                                                  :rate_key=>"073603a3-9c80-43f8-813c-11734dfe1c37",
                                                                  :rate_code=>201572293},
                                                               "1 Queen jt ste gndvw N/S"=>
                                                                 {:average_rate=>"228.0",
                                                                  :total_cost=>"1596.0",
                                                                  :room_type_code=>"404489",
                                                                  :rate_key=>"e1d91698-dd18-47fd-98a4-e209be62841b",
                                                                  :rate_code=>1385824},
                                                               "One King Bed, Smoking"=>
                                                                 {:average_rate=>"228.0",
                                                                  :total_cost=>"1596.0",
                                                                  :room_type_code=>"200266992",
                                                                  :rate_key=>"b5e55dcc-d552-4b32-907e-d7b7aac7e1db",
                                                                  :rate_code=>201572383},
                                                               "Junior Suite, One King Bed, Non-Smoking"=>
                                                                 {:average_rate=>"249.0",
                                                                  :total_cost=>"1743.0",
                                                                  :room_type_code=>"200266972",
                                                                  :rate_key=>"4f2c12c8-84d0-48cd-a937-c93ebb535deb",
                                                                  :rate_code=>201572275}})

      end
    end
  end
end