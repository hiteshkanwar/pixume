class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    user = current_user || User.find_by_email(omniauth['info']['email'])

    if authentication && authentication.user.present? && authentication.user == user
      user = authentication.user
    elsif !user.blank?
      user.create_authentication_from_omniauth(omniauth)
      #session[:linkedin_callback] = "/profile/from_linkedin"
    else
      user = User.new
      user.apply_omniauth(omniauth)
      user.skip_confirmation!
      user.save(:validate => false)
    end
	@location=Geokit::Geocoders::GoogleGeocoder.geocode ("#{omniauth.extra.raw_info.location.name}")

      if !user.user_location.blank?

        user.user_location.last.update_attributes(:zip=>@location.zip,:city=>@location.city,:state=>@location.state,:latitude=>@location.lat.to_f,:longitude=>@location.lng.to_f,:country=>@location.country,:user_id=>user.id)
      else
        user.user_location.create(:zip=>@location.zip,:city=>@location.city,:state=>@location.state,:latitude=>@location.lat.to_f,:longitude=>@location.lng.to_f,:country=>@location.country)

      end
    flash[:notice] = "Signed in successfully."
    sign_in :user, user, :bypass => true if !current_user
    if !session[:linkedin_callback].blank?
      session_redirect_to = session[:linkedin_callback]
      session.delete(:linkedin_callback)
      redirect_to session_redirect_to
    elsif user
      redirect_to root_path
    end
  end

  def failure
    reset_session
    flash[:notice] = 'Login Unsuccessful'
    redirect_to root_path
  end
end
