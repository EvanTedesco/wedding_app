require 'spec_helper'

feature 'password select' do
  scenario 'It sends user an email to set their password' do
    emails_sent = ActionMailer::Base.deliveries.length
    create_and_login_admin
    click_link 'Users'
    fill_in 'user[name]', with: 'new user'
    fill_in 'user[email]', with: 'jeff@example.com'
    fill_in 'user[max_guests]', with: 1
    click_button 'Create user'
    click_link 'Logout'

    expect(ActionMailer::Base.deliveries.length).to eq (emails_sent + 1)

    email_message = ActionMailer::Base.deliveries.last.body.raw_source
    @doc = Nokogiri::HTML(email_message)
    result = @doc.xpath("//html//body//p//a//@href")[0].value
    visit result
    click_button 'Submit'

    expect(page).to have_content 'Password can\'t be blank'

    fill_in 'user[password]', with: 'newpassword'
    fill_in 'user[password_confirmation]', with: 'newpassword'
    click_button 'Submit'

    expect(page).to have_content 'You\'re invited'
  end
end