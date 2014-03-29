class Rating < ActiveRecord::Base
  attr_accessible :num_connections, :num_groups, :num_posts_per_month, :num_recommendations, :user_id
  belongs_to :user
end
