class CreateFood < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.string :description
    end
  end
end
