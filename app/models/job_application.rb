class JobApplication < ActiveRecord::Base
  attr_accessible :job_posting_id, :user_id
   belongs_to :job_postings
   belongs_to :users

 @@availablity_weeks = [1,2,3,4,5,6,7,8,9,10]
  
  cattr_accessor :availablity_weeks
end
