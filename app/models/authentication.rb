class Authentication < ActiveRecord::Base
  attr_accessible :uid, :provider, :access_token, :expires_in, :as => :default  
  
  validates_uniqueness_of :uid, :scope => [:provider, :user_id]

  serialize :api_response
  
  belongs_to :user

  def attribute_from_omniauth(omniauth)
    self.api_response = omniauth
    self.provider = omniauth['provider']
    self.uid = omniauth['uid']
    self.access_token = omniauth["credentials"]["token"]
    self.access_token_secret = omniauth["credentials"]["secret"]

    if omniauth['provider'] == 'facebook'
      self.expires_in = omniauth["credentials"]["expires_at"]
    elsif omniauth['provider'] == 'linkedin'
      self.expires_in = omniauth["extra"]["access_token"].params['oauth_expires_in']
    end
  end   
end