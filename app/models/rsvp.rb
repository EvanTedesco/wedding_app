class Rsvp < ActiveRecord::Base


  validates :attending, inclusion: [true, false]

  belongs_to :user
end