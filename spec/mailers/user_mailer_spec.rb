require 'spec_helper'

describe UserMailer do
before do
   DatabaseCleaner.clean
   @user = create_user('password')

end

describe 'message when user is created' do

   let(:message) { UserMailer.welcome_email(@user) }


   it 'comes from the proper user' do
     expect(message.from).to eq ['evan@example.com']
   end

   it 'goes to the proper user' do
     expect(message.to).to eq ['bob@example.com']
   end

   it 'has the proper subject' do
     expect(message.subject).to eq "Let's party!"
   end
end
end