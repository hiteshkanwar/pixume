class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :except => [:welcome]

  def index
    if user_signed_in? and current_user.role == "recruiter"
      redirect_to search_pixsume_path
    elsif user_signed_in? and !current_user.visited_profile
     if !current_user.try(:published_profile)
        render 'welcome'
      else
        redirect_to pixsume_path
      end
    elsif user_signed_in? and !current_user.published_profile
      redirect_to profile_path
    elsif user_signed_in? and current_user.published_profile
      redirect_to public_pixsume_path(current_user.profile_name)
    else
      render :template => "devise/sessions/new"
    end
  end

  def welcome;  end

  def how_it_works; end

  def about_us; end

  def contact_us; end

  def terms_of_services; end

  def privacy_policy; end
  
  def press_release; end
  
  def jobs; end

end
