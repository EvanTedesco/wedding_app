require 'spec_helper'

describe 'Photo' do
  before do
    DatabaseCleaner.clean
    @user = create_user
    @photo = create_photo({url:'http://38.media.tumblr.com/7ec15487856dbf285d695e5a4f8e12ef/tumblr_n6rzwbv3ji1st5lhmo1_1280.jpg', user_id:@user.id})
  end
  it 'displays photos on the index page' do
    visit '/sessions/new'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Login'
    expect(page).to have_content 'Welcome Bob Smith'
    click_on 'Photos'
    p @photo.url
    page.should have_xpath("//img[@src=#{@photo.url}\"]")
  end

end