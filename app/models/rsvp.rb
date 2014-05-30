class Rsvp < ActiveRecord::Base


  validates :attending, inclusion: [true, false]
  validates  :number_of_guests, numericality:  {only_integer: true, greater_than_or_equal_to: 0}, if: :attending?

  belongs_to :user

  def attending?
  if :attending

  end
  end

end