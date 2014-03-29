class ResumeFile < ActiveRecord::Base
  belongs_to :job_application
  belongs_to :user
  attr_accessible :job_application_id, :file,:user_id
  

   has_attached_file :file,
					 :storage => :s3,
                    :bucket => 'pixsume',
                    :s3_credentials => {
                    :access_key_id => 'AKIAIEZOHCBENVLU5EFA',
                    :secret_access_key => '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'
                    }
   	
end
