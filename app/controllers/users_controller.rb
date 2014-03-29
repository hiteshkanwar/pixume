class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:public_pixsume]
  
  def home
  end

  def standout
  end

  def profile
  
    if ((request.referrer== "http://localhost:3000/welcome") || (request.referrer== "http://localhost:3000/"))
      if !session[:return_to].nil?
        flash[:notice] = " Your Pixsume is not created, Please create your pixsume "
      end
    end
    
   if user_signed_in? && current_user	

    if !current_user.visited_profile == true
       
      profile_name = current_user.name.downcase.gsub(/\s+/, "")
      user = User.find(:first, :conditions => ["lower(profile_name) like ?", profile_name])

      if !user.blank?
        random_string = SecureRandom.hex(4)
        profile_name = random_string + "-" + profile_name;
      end

      current_user.update_attribute(:profile_name, profile_name)

      current_user.update_attribute(:visited_profile, true)
    end
  end
    @user = current_user
  end

     def edit_basic_profile
    
        @states =["United States","United Kingdom","Canada","India","Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burma", "Burundi", "Cambodia", "Cameroon",  "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo, Democratic Republic", "Congo, Republic of the", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Greenland", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hong Kong", "Hungary", "Iceland",  "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, North", "Korea, South", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Mongolia", "Morocco", "Monaco", "Mozambique", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Oman", "Pakistan", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Samoa", "San Marino", " Sao Tome", "Saudi Arabia", "Senegal", "Serbia and Montenegro", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "Spain", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Uganda", "Ukraine", "United Arab Emirates", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"]

    
    @user = current_user
    
    if !current_user.user_location.last.blank?
      @country=current_user.user_location.last.country
      
      if !current_user.user_location.last.zip.nil?
        @zip=current_user.user_location.last.zip
      else
        @zip=current_user.user_location.last.city  
      end
    end
    render :layout => false
    
  end

  def edit_summary
    @user = current_user
    render :layout => false
  end
  def edit_resume
  	User.find(params[:user_id]).resume_files.delete_all
 session[:file_remove]="success"
  	redirect_to root_path  
  end


  def edit_video
    @user = current_user
    render :layout => false
  end

  def show
    @user = User.find params[:id]
    render 'profile'
  end

  def update
    
    @user = current_user
    @user.update_attributes(params[:user])  
    
    if !params[:radio].nil?
         
    @location_exist=current_user.user_location.last
    if !@location_exist.blank?
     
      @location_exist.update_attributes(:zip=>params[:zip],:city=>params[:city],:state=>params[:state],:latitude=>params[:lat].to_f,:longitude=>params[:long].to_f,:country=>params[:country],:user_id=>current_user.id)
    else  
      current_user.user_location.create(:zip=>params[:zip],:city=>params[:city],:state=>params[:state],:latitude=>params[:lat].to_f,:longitude=>params[:long].to_f,:country=>params[:country])
    end
  end
   
  end


  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to root_path
  end

  def profile_from_linkedin
    
    @user = current_user
    linkedin_auth = current_user.authentications.first
     
    if linkedin_auth.blank?
      #session[:linkedin_callback] = "/my/profile"
      session[:linkedin_callback] = "/profile/from_linkedin"
      redirect_to "/auth/linkedin"
    else
      linkedin_client = LinkedIn::Client.new#(linkedin_auth.access_token, linkedin_auth.access_token_secret)
      linkedin_client.authorize_from_access(linkedin_auth.access_token, linkedin_auth.access_token_secret)
      linkedin_data = linkedin_client.profile(:fields => ['positions', 'educations', 'skills', 'summary', "picture-url", "num-connections", "num-recommenders"])
      linkedin_groups_data = linkedin_client.group_memberships(:fields => ['group'])

      unless linkedin_data.educations.blank?
        Education.create_from_linkedin(@user, linkedin_data.educations.all)
      end
      unless linkedin_data.positions.blank?
        Experience.crate_from_linkedin(@user, linkedin_data.positions.all)
      end
      unless linkedin_data.skills.blank?
        SkillSet.create_from_linkedin(@user, linkedin_data.skills.all)
      end

      #logger.debug linkedin_groups_data
      #logger.debug "logging linkedin info..."
      #logger.debug "connections count: #{linkedin_data.num_connections}"
      #logger.debug "recommendations count: #{linkedin_data.num_recommenders}"
      #logger.debug "groups count: #{linkedin_groups_data.total}"
      #unless linkedin_groups_data.group.blank?
      #  logger.debug "groups count: #{linkedin_groups_data.group.size}"
      #end

      num_connections = linkedin_data.num_connections
      num_recommendations = linkedin_data.num_recommenders
      num_groups = linkedin_groups_data.total

      Rating.create(:user_id => @user.id, :num_connections => num_connections, :num_recommendations => num_recommendations, :num_groups => num_groups, :num_posts_per_month => 0)

      current_user.set_from_linkedin({:summary => linkedin_data.summary, :profile_picture => linkedin_data.picture_url})
      session.delete(:linkedin_callback)
      redirect_to pixsume_path
    end
  end

  def my_home
    render :my_home
  end

  def pixsume

    #@user = User.find params[:user_id]
    if !current_user.try(:published_profile)
      current_user.update_attribute(:published_profile, true)
    end
    
    @user = current_user
    
    
  end

  def my_pixsume
    
    pixsume
    if !current_user.profile_name.nil?
      redirect_to public_pixsume_url(current_user.profile_name)
    else
      profile_name = current_user.name.downcase.gsub(/\s+/, "")
      current_user.update_attribute(:profile_name, profile_name)
      if session[:return_to].nil?
      redirect_to public_pixsume_url(current_user.profile_name)
      else
        @c= session[:return_to]
        session[:return_to]= nil
        redirect_to @c
      end
    end
  end

 def public_pixsume
   
    if !params[:username].nil?
      if !User.find_by_profile_name(params[:username]).nil?
        @schools= User.find_by_profile_name(params[:username]).educations
        @experiences= User.find_by_profile_name(params[:username]).experiences
        @number_of_companies=@experiences.collect(&:company_name).uniq.count
      end 
    end 
    #@schools = current_user
    
    @total_exp=0
    @exp_count=0
    user = User.find(:first, :conditions => ["lower(profile_name) like ?", params[:username].downcase])
    #@experiences=current_user.experiences
   
   
    if !@experiences.blank?
      @experiences.each do |experience|
        if  !experience.from_year.blank?
          
          if !experience.to_year.blank?
            @exp_count=experience.to_year.to_i - experience.from_year.to_i
          else
            
            @exp_count=Date.today.year - experience.from_year.to_i
          end  
        end
       
        if @exp_count > 0
        @total_exp += @exp_count
        
        
    
        end
      end
    end
    if !user.blank?
      @user = user
      render :public_pixsume
    else
      #render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
      flash.now[:error] = "Could not find user for " + params[:username]
      redirect_to root_path
    end
  end

  def search_pixsume
    if !params[:q].blank?
      @page = (params[:page] || 1).to_i
      search = Sunspot.search(User) do |s|
        if params.has_key?(:criteria) && !params[:criteria].empty?
          s.fulltext params[:criteria]
        else
          s.fulltext "aa"
        end
        s.paginate :per_page => 20, :page => @page
      end
      @users = search.results
    end
    render :search_pixsume
  end
def show_profile
  
    if !params[:job_posting_id].nil?
      @users=[]
      @user_social_rating = []
      @user_resume_rating = []
      @job_posting=JobPosting.find(params[:job_posting_id])
      @jobs_application=JobApplication.where(:job_posting_id => params[:job_posting_id])

      @jobs_application.each do |jobs_application|
        @users << User.find(jobs_application.user_id)
	@user_check = User.find(jobs_application.user_id).get_social_rating
        if !@user_check.nil?
        @user_social_rating << User.find(jobs_application.user_id).get_social_rating.round(1)
        end
        user =User.find(jobs_application.user_id)
        resume_rating = 0
        course_score = 0
        school_score = 0
        exp_score = 0
        unless user.get_course_score.blank?
          course_score = user.get_course_score
        end
        unless user.get_school_score.blank?
          school_score = user.get_school_score
        end         
        unless user.get_exp_score.blank?
          exp_score = user.get_exp_score
        end
        resume_rating = ( ( course_score * 30 ) + ( school_score * 20 ) + ( exp_score * 50 ) ) / 100
        @user_resume_rating << resume_rating
      end
      
      (0...(@users.count-1)).each do |index|
          
          (0...@users.count).each do |index|
            
            if !@user_resume_rating[index+1].nil?
              if @user_resume_rating[index+1] > @user_resume_rating[index] 
                @temp_rating = @user_resume_rating[index] 
                @temp = @users[index]

                @user_resume_rating[index] = @user_resume_rating[index+1]
                @users[index] = @users[index+1]

                @user_resume_rating[index+1] = @temp_rating
                @users[index+1] = @temp
              end
            end
          end
        end
       
      if params[:data] == "Name"
        @users = @users.sort_by{|e| e[:name]}  
      end

       if params[:data]=="Resume Rating"
        
         (0...(@users.count-1)).each do |index|
          
           (0...@users.count).each do |index|
            
            if !@user_resume_rating[index+1].nil?
              if @user_resume_rating[index+1] > @user_resume_rating[index] 
                 @temp_rating = @user_resume_rating[index] 
                @temp = @users[index]

                @user_resume_rating[index] = @user_resume_rating[index+1]
                @users[index] = @users[index+1]

                @user_resume_rating[index+1] = @temp_rating
                @users[index+1] = @temp
              end
            end
          end
        end
      end

      if params[:data]=="Social Rating"

        (0...(@users.count-1)).each do |index|
          
          (0...@users.count).each do |index|
            
            if !@user_social_rating[index+1].nil?
              if @user_social_rating[index+1] > @user_social_rating[index] 
                @temp_rating = @user_social_rating[index] 
                @temp = @users[index]

                @user_social_rating[index] = @user_social_rating[index+1]
                @users[index] = @users[index+1]


                @user_social_rating[index+1] = @temp_rating
                @users[index+1] = @temp
              end
            end
          end
        end              
      end

      if params[:data] == "Current Company"
        @current_company=[]
        @users.each do |user|
          user.experiences.each do |user_exp|
            if user_exp.is_current
              @current_company << user_exp
            end  
          end  
        end  
        @users=[]
        
        @company=@current_company.sort_by{|e| e[:company_name]}
        @company.each do |company|
         @users << User.find(company.user_id)
        end  

      end

      if params[:data] == "Salary"
        @jobs_application = @jobs_application.sort_by{|e| e[:expected_salary]}.reverse!
        @users=[]
        @jobs_application.each do |jobs_application|
          @users << User.find(jobs_application.user_id)      
        end
      end
    end

    if params[:data].nil?   
      render :show_profile
    else
      respond_to do |format|
        format.js
      end
    end   
 end 

def upload_file
   
    @file = current_user.resume_files.create(:file=>params[:file])
    session[:file_saved]="success"
   
    redirect_to pixsume_path
  end
def error_event
  session[:event] = params[:path]
  respond_to do |format|
    format.js
  end
end
  def download_pdf
  
    @user = User.find(params[:user_id])
     if !@user.nil?
    
        @schools= @user.educations
        @experiences= @user.experiences
        @number_of_companies=@experiences.collect(&:company_name).uniq.count
      
    end 
    #@schools = current_user
    
    @total_exp=0
    @exp_count=0
    # user = User.find(:first, :conditions => ["lower(profile_name) like ?", params[:username].downcase])
    #@experiences=current_user.experiences
   
   
    if !@experiences.blank?
      @experiences.each do |experience|
        if  !experience.from_year.blank?
          
          if !experience.to_year.blank?
            @exp_count=experience.to_year.to_i - experience.from_year.to_i
          else
            
            @exp_count=Date.today.year - experience.from_year.to_i
          end  
        end
       
        if @exp_count > 0
        @total_exp += @exp_count
        
        
    
        end
      end
    end
      @applied_job=@user.job_applications.order("updated_at DESC")

    
    html = render_to_string(:layout => false )
    kit = PDFKit.new(html, :page_size => 'Letter')
    send_data(kit.to_pdf, :filename => "#{@user.name}_pixsume", :type => 'application/pdf')
    
 
  end
	def requestor_pdf
		@requestors=Requestor.order("id DESC").all
		@skills = []
		@requestors.each do |requestor|
		  @skills<<SkillSet.find(requestor.skill_set_id).name
		end
		@skill_uniq=@skills.uniq
		sort_me = []
		@skill_uniq.each do |skill|    
		  sort_me.push({"skill"=>skill, "count"=>@skills.select{|e| e == skill}.count})
		  @sorted = sort_me.sort_by { |k| k["count"] }
		end

		html = render_to_string(:layout => false )
		kit = PDFKit.new(html, :page_size => 'Letter')
		send_data(kit.to_pdf, :filename => 'Requestors_pixsume', :type => 'application/pdf')
	  end

	def user_location
		@location=Geokit::Geocoders::GoogleGeocoder.geocode ("#{params[:zip]},#{params[:country]}")
	 		respond_to do |format|
		  format.js
		end
  	end
  def job_mached
    @job_main_array = []
    @job_main_array << match_city 
    @job_main_array << job_title
    @job_main_array << job_skill
    @job_main_array = @job_main_array.flatten.uniq
  end
def job_detail

  @job=JobPosting.find(params[:id].to_i)
    respond_to do |format|
      format.js
    end
  end
def search_by_keys
    
   if params[:value]=="City"
    if !params[:key].blank?
      @searched_jobs=JobPosting.where('location LIKE ?', "%#{params[:key].downcase}%")
    end 
   elsif params[:value]=="Title"
      if !params[:key].blank?
    @searched_jobs=JobPosting.where('title LIKE ?', "%#{params[:key].downcase}%")
      end
   else

     @job_posting=JobPosting.all
     @searched_jobs=[]
     @job_posting.each do |job_posting|  
                 
          @job_posting_requirnment=job_posting.requirements.downcase
          if @job_posting_requirnment.include?(',')
            @job_posting_requirnment=@job_posting_requirnment.gsub(","," ") 
          end
          if @job_posting_requirnment.include?('/')
            @job_posting_requirnment=@job_posting_requirnment.gsub("/"," ") 
          end

          if @job_posting_requirnment.include?(params[:key])
            @searched_jobs<<job_posting
          end 
      end
    end  

     
    respond_to do |format|
      format.js
    end
  end





private

  def match_city
    
    if !current_user.user_location.last.nil?
      @job_posting=JobPosting.where(:country=>current_user.user_location.last.country)
    end
      @matched_city_jobs=[]

    
    if !@job_posting.nil?
      @job_posting.each do |job_posting|
        
        
          
          if job_posting.location==current_user.user_location.last.city.split[0]

            @matched_city_jobs<<job_posting

          end 
          
      end
    end    
      
    return @matched_city_jobs
  end 

private
  def job_title
    @sorted_job_designation=current_user.experiences.order("to_year DESC")
	if !current_user.user_location.last.nil?
   	 @job_posting=JobPosting.where(:country=>current_user.user_location.last.country)
    else
     @job_posting=JobPosting.all
    end
    @matched_title_jobs=[]

    @sorted_job_designation.each do |jobb|
          
      @job_posting.each do |job_posting|
        
       if jobb.designation.downcase==job_posting.title.downcase

        @matched_title_jobs<<job_posting  
       
       end 
      end 
     
    end
  
    return @matched_title_jobs
  end  
private
  def job_skill

	if !current_user.user_location.last.nil?
    	@job_posting=JobPosting.where(:country=>current_user.user_location.last.country)
    else
    	@job_posting=JobPosting.all
    end
    @skills=current_user.skill_sets
    @matched_skill_jobs=[]
   
      @job_posting.each do |job_posting|
        count=0

        @skills.each do |skill|
          
          @job_posting_requirnment=job_posting.requirements.downcase
          if @job_posting_requirnment.include?(',')
            @job_posting_requirnment=@job_posting_requirnment.gsub(","," ") 
          end
          if @job_posting_requirnment.include?('/')
            @job_posting_requirnment=@job_posting_requirnment.gsub("/"," ") 
          end

          if @job_posting_requirnment.include?(skill.name.downcase)
            count=count+1
          end
          if count > 3
            @matched_skill_jobs<<job_posting
          end
        end
      end

    return @matched_skill_jobs
  end      

end

