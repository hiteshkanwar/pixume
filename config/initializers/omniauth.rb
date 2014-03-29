Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  provider :linkedin, Settings.social_apps.linkedin.consumer_key, Settings.social_apps.linkedin.consumer_secret, :scope => 'r_basicprofile r_fullprofile r_emailaddress r_network r_contactinfo rw_groups rw_nus w_messages',
      :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "skills", "date-of-birth", "phone-numbers", "educations", "three-current-positions" ]
end

# OAuth::Problem parameter_absent; request parameters: {"oauth_problem"=>"user_refused"}
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
