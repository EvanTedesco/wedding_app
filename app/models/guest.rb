class Guest < ActiveRecord::Base

  belongs_to :user

  belongs_to :food
  accepts_nested_attributes_for :food
end