class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :num_connections
      t.integer :num_recommendations
      t.integer :num_groups
      t.integer :num_posts_per_month

      t.timestamps
    end
  end
end
