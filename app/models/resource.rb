class Resource < ActiveRecord::Base
  belongs_to :skill_set
  belongs_to :user
  attr_accessible :approved, :description, :link, :name, :paid, :source, :user_id,:resource_name
validates :link, :format => URI::regexp(%w(http https))
  attr_accessible :logo

  has_attached_file :logo, :styles => {:thumb => "87x87"},
                    :default_url => "/assets/images/profile.png",
                    :url => "/assets/users/:id/:style/:basename.:extension",
                    :storage => :s3,
                    :bucket => 'pixsume',
                    :s3_credentials => {
                    :access_key_id => 'AKIAIEZOHCBENVLU5EFA',
                    :secret_access_key => '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'
                    }
end
