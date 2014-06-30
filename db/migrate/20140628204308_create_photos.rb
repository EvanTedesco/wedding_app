class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url
      t.index :user_id
      t.integer :user_id

    end
  end
end
