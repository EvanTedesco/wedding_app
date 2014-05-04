class CreateRsvpTable < ActiveRecord::Migration
    def change
      create_table :rsvps do |t|
        t.string :name
        t.string :email
        t.boolean :attending
        t.integer :max_guests
        t.integer :number_of_guests
        t.string :comments
        t.string :meal_preference

        t.timestamps
      end
    end
  end