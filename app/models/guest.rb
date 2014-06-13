class Guest < ActiveRecord::Base

  belongs_to :user
  has_one :food
  accepts_nested_attributes_for :food
end