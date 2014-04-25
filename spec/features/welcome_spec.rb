require 'spec_helper'

feature 'Welcome Page' do
  scenario 'It shows a welcome page' do
    visit '/'
    expect(page).to have_content "Evan and Crystal Tedesco's Awesome Wedding Site"

  end
end