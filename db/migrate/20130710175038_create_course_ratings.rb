class CreateCourseRatings < ActiveRecord::Migration
  def change
    create_table :course_ratings do |t|
      t.string :name, :null => false
      t.integer :score, :null => false, :default => 1

      t.timestamps
    end
    add_index :course_ratings, :name, :unique => true
  end
end
