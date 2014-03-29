class SitemapController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    @static_urls = [ {:url => '/', :updated_at => ""},
                    {:url => '/how-it-works', :updated_at => ""},
                    {:url => '/about-us', :updated_at => ""},
                    {:url => '/contact-us', :updated_at => ""},
                    {:url => '/terms-of-services', :updated_at => ""},
                    {:url => '/privacy-policy', :updated_at => ""},
                    {:url => '/press-release', :updated_at => ""},
                    {:url => '/jobs', :updated_at => ""} ]

    @pages_to_visit = []

    @pages_to_visit += User.where('published_profile IS NOT NULL AND profile_name IS NOT NULL').collect{ |user| {:url => public_pixsume_path(user.profile_name), :priority => '1.0', :changefreq => 'daily', :updated_at => I18n.l(user.updated_at, :format => :w3c)} }

    respond_to do |format|
      format.xml
    end
  end

end
