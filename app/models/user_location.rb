class UserLocation < ActiveRecord::Base
  belongs_to :user
  attr_accessible :city, :country, :latitude, :longitude, :state, :street, :zip,:user_id
	
end
