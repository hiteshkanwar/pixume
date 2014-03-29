class Requestor < ActiveRecord::Base
  attr_accessible :requested_date, :requestor_email, :requestor_name, :skill_set_id, :user_id
end
