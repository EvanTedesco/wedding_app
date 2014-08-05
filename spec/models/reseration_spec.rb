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

        expect(Reservation.new(request).get_room_info["Two Doubles"]).to eq({
                                                                              :average_rate => "303.7143",
                                                                              :total_cost => "2126.0",
                                                                              :room_type_code => "223811",
                                                                              :description=>"<strong><ul><li>2 double</li></ul></strong>Slip into the pillowtop bed with Egyptian cotton linens and a down duvet for a good night's rest. Wireless Internet access (surcharge) keeps you connected, and the 37-inch flat-screen TV offers cable channels. You can unwind in your private spa tub. A coffee/tea maker is provided. The private bathroom has a bathtub or shower, as well as complimentary toiletries and a hair dryer. Air conditioning, a safe, and daily housekeeping are among the conveniences offered.  <p></p>",
                                                                              :amenities=>["Air conditioning", "Bathtub or shower", "Blackout drapes/curtains", "Cable TV service", "Climate control", "Coffee/tea maker", "Complimentary toiletries", "Connecting / adjoining rooms available ", "Cribs/infant beds available", "Daily housekeeping", "Down comforter ", "Egyptian-cotton sheets ", "Flat-panel TV", "Hair dryer", "Hypo-allergenic bedding available", "In-room safe", "Iron/ironing board", "MP3 docking station", "Phone", "Pillowtop mattress ", "Private bathroom", "Private spa tub", "Rollaway/extra beds available", "Wireless Internet access (surcharge)"],
                                                                              :smoking_preference=>"S,NS",
                                                                              :rate_key => "045e5708-e2d1-4536-8743-795b403a321c",
                                                                              :rate_code=>545532}
                                                                         )
      end
    end
  end
end