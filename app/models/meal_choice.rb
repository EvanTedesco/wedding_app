class MealChoice < ActiveRecord::Base
  belongs_to :rsvp
  belongs_to :food

end
