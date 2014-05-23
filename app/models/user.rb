class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_one :rsvp

  def admin?
    admin == true
  end

end
