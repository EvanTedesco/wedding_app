class Guest < ActiveRecord::Base

  belongs_to :rsvp
  has_one :food
end