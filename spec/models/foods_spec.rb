require 'spec_helper'

describe 'Validates food info' do
  it 'limits description size to 255 characacters' do
    valid_food = Food.create!(name: 'Channa Masala', description: 'Delicious')
    invalid_food = Food.create(name: 'Channa Masala', description: 'neckbeards' * 26)
    expect(valid_food).to be_valid
    expect(invalid_food).to be_invalid
  end

  it 'limits food name to 255 characters' do
    valid_food = Food.create!(name: 'Channa Masala', description: 'Delicious')
    invalid_food = Food.create(name: 'Channa Masala' * 26, description: 'neckbeards')
    expect(valid_food).to be_valid
    expect(invalid_food).to be_invalid

  end

end