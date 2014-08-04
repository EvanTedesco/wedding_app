require 'spec_helper'

describe 'EmailJob' do
  it 'sends an email' do
    user = create_user(auth_token: SecureRandom.urlsafe_base64)
    emails_sent = ActionMailer::Base.deliveries.length
    EmailJob.new.async.perform(user)

    expect(ActionMailer::Base.deliveries.length).to eq (emails_sent + 1)
  end
end