class Food < ActiveRecord::Base
  validates :description, length:{ maximum:255}
  validates :name, length:{ maximum:255}

  belongs_to :meal_choice
end