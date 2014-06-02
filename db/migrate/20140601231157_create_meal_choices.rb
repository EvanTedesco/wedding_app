class CreateMealChoices < ActiveRecord::Migration
  def change
    create_table :meal_choices do |t|
      t.integer :rsvp_id
      t.integer :food_id

      t.timestamps
    end
    add_index :meal_choices, :rsvp_id
    add_index :meal_choices, :food_id
  end
end
