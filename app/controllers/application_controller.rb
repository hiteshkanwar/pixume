class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :authenticate_user!
  before_filter :set_cache_buster
  before_filter :track_user_activity
  helper_method :logged_in? #1.0
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def track_user_activity
    if logged_in?
      @activity = UsageTracking.where(:session_id => session[:session_id]).first || UsageTracking.new
      @activity.update_attributes(:session_id => session[:session_id], :user_name => current_user.name, :user_email => current_user.email, :last_access_url => "#{request.fullpath}");
    end
  end

  def logged_in?
    !!current_user
  end
end
