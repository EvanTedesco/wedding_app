class CreateGuestMealChoice < ActiveRecord::Migration
  def change
    create_table :guest_meal_choices do |t|
      t.integer :guest_id
      t.index :guest_id
      t.integer :food_id
      t.index :food_id
    end
  end
end
