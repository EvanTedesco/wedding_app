class Rsvp < ActiveRecord::Base
  validates :attending, inclusion: [true, false]
  validates :number_of_guests, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: :guest_limit}, if: :attending?
  validates :user_id, presence: true

  belongs_to :user
  has_one :meal_choice
  accepts_nested_attributes_for :meal_choice

  has_many :guests
  accepts_nested_attributes_for :guests

  def attending?
    attending
  end

  def guest_limit
    user = User.find(self.user.id)
    user.max_guests if user
  end
end
