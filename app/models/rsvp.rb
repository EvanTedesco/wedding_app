class Rsvp

  include ActiveModel::Validations
  include ActiveModel::Conversion

  validates :number_of_guests,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: :guest_limit,
            message: "Please select a valid number of guests" },
            if: :attending?
  validates :attending, inclusion: {in: [true, false], message: "You must accept or decline"}


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
                                food_id: user_food_id,)
        if user.attending
          guests.each do |guest|
            Guest.create!(user_id: user.id, name: guest[0], food_id: guest[1])
          end
        end
      end
    end
    valid
  rescue
    false
  end

  def user
    @attributes[:user] ||= User.find(@attributes[:user_id])
  end

  def guests
    names = []
    foods = []
    guests = @attributes['guests'].to_a
    guests.each do |guest|
      names << guest[1]['name']
      foods << guest[1]['food_id']
    end
    guest_info = names.zip(foods)
    guest_info.delete_if do |guest|
      guest[0].empty?
    end
  end

  def attending?
    attending
  end

  def attending
    if @attributes[:attending] == "true"
      true
    elsif @attributes[:attending] == "false"
      false
    end
  end

  def number_of_guests
    @attributes[:number_of_guests]
  end

  def guest_food_id
    @attributes[:guests][:food_id]
  end

  def guest_name
    @attributes[:guests][:name]
  end

  def user_food_id
    @attributes[:user_food_id]
  end

  def comments
    @attributes[:comments]
  end

  def guest_limit
    user.max_guests
  end


end
