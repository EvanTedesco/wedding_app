class Guest < ActiveRecord::Base

  belongs_to :users
  has_one :food
end