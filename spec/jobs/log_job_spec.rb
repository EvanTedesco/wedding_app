require 'spec_helper'

describe EmailJob do
  
  describe '#perform' do
    let(:user) { create_user(auth_token: '2a$10$2lZ3kZICGM9z4PNbIOXueeu93ui8VA0Gqf7T.xTIuUEuNtNY.7TR2')}

    it 'delivers an email' do
      expect {
        EmailJob.new.perform(user)
      }.to change{ ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end