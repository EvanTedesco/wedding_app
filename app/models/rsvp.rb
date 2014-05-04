class Rsvp < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :attending, presence: true
end