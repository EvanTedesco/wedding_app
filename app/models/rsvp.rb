class Rsvp

  include ActiveModel::Validations
  include ActiveModel::Conversion

  #attr_accessor :attending, :number_of_guests, :guest_name,
  #              :user_food_id, :guest_food_id, :comments, :attributes

  validates :number_of_guests,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: :guest_limit},
            if: :attending?
  validates :user, presence: true
  #validates :attending, inclusion: [true, false]

  validate do
    [user, guest].each do |object|
      unless object.valid?
        object.errors.each do |key, values|
          errors[key] = values
        end
      end
    end
  end


  def persisted?
    false
  end

  def initialize(attributes = {})
    @attributes = attributes
  end

  def save_fields
    valid = self.valid?
    if valid
      user.update_attributes!(attending: attending,
                              number_of_guests: number_of_guests,
                              food_id: user_food_id)
      guest.save!
    end
    valid
  end

  def user
    @user ||= User.find(@attributes[:user_id])
  end

  def guest
    @guest ||= Guest.new(user_id: user.id, name: guest_name,
                         food_id: @attributes[:guest_food_id])
  end

  def attending
    @attending ||= @attributes[:attending]
  end

  def attending?
    @attending
  end

  def number_of_guests
    @number_of_guests ||= @attributes[:number_of_guests].to_i
  end

  def guest_food_id
    @guest_food_id ||= @attributes[:guest_food_id]
  end

  def guest_name
    @guest_name ||= @attributes[:guest_name]
  end

  def user_food_id
    @user_food_id ||= @attributes[:user_food_id]
  end

  def comments
    @comments ||= @attributes[:comments]
  end


  def guest_limit
    user.max_guests
  end

end
# add a method for save or update_attributes or something
# find a user by the id
# instantiate meal choices etc...
# call valid?  if they are valid
#   save them all
# return true or false
