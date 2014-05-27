class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.integer :user_id
      t.index :user_id
      t.boolean :attending
      t.integer :number_of_guests
      t.string :comments
      t.string :meal_preference
    end
  end
end
