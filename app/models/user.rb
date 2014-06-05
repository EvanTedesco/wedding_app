class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates  :max_guests, numericality:  {only_integer: true, greater_than_or_equal_to: 0}


  has_one :rsvp, :dependent => :destroy
  has_one :food, through: :rsvp

  def admin?
    admin
  end
end
