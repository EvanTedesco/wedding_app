class Rsvp < ActiveRecord::Base


  validates :attending, inclusion: [true, false]
  validates :number_of_guests, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: :guest_limit}, if: :attending?


  belongs_to :user
  has_one :meal_choice
  accepts_nested_attributes_for :meal_choice

  def attending?
    attending
  end

  def guest_limit
      current_user = User.find(self.user_id)
      current_user.max_guests
  end
end
