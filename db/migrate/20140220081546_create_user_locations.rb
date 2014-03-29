class CreateUserLocations < ActiveRecord::Migration
  def change
    create_table :user_locations do |t|
      t.integer :zip
      t.string :street
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude
      t.string :country
      t.references :user

      t.timestamps
    end
    add_index :user_locations, :user_id
  end
end
