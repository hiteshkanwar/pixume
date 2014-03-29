class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :user_id
      t.string :institute
      t.string :course
      t.string :from_month
      t.string :from_year
      t.string :to_month
      t.string :to_year
      t.boolean :currently_attending
      t.string :location
      t.timestamps
    end
  end
end
