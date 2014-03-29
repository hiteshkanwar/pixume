class UsageTracking < ActiveRecord::Base
  attr_accessible :last_access_url, :session_id, :user_email, :user_name
end
