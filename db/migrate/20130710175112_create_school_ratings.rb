class CreateSchoolRatings < ActiveRecord::Migration
  def change
    create_table :school_ratings do |t|
      t.string :name, :null => false
      t.integer :score, :null => false, :default => 1

      t.timestamps
    end
    add_index :school_ratings, :name, :unique => true
  end
end
