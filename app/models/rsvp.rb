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
    unless user.valid?
      user.errors.each do |key, values|
        errors[key] = values
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
      User.transaction do
        user.update_attributes!(attending: attending,
                                number_of_guests: number_of_guests,
                                food_id: user_food_id)
        guests.each do |guest|
          Guest.create!(user_id: user.id, name: guest[0], food_id: guest[1])
        end
      end
    end
    valid
  rescue
    false
  end

  def user
    @user ||= User.find(@attributes[:user_id])
  end

  def guests
    names = []
    foods = []
    guests = @attributes['guests'].to_a
    guests.each do |guest|
      names << guest[1]['name']
      foods << guest[1]['food_id']
    end
    names.zip(foods)

  end

  # def guest
  #   @guest ||= Guest.new(user_id: user.id, name: guest_name,
  #                        food_id: guest_food_id)
  #
  #
  # end


  def attending
    @attributes[:attending] == "true"
  end

  alias attending? attending

  def number_of_guests
    @number_of_guests ||= @attributes[:number_of_guests].to_i
  end

  def guest_food_id
    @guest_food_id ||= @attributes[:guests][:food_id]
  end

  def guest_name
    @guest_name ||= @attributes[:guests][:name]
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

  def generate_fields(user)
    finished = false
    until finished
      user.max_guests.times do
        user.guests.build
        finished = true
        break
      end
    end
  end

end
# add a method for save or update_attributes or something
# find a user by the id
# instantiate meal choices etc...
# call valid?  if they are valid
#   save them all
# return true or false
