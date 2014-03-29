class SkillSetsController < ApplicationController
  def index
    @skill_sets = SkillSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skill_sets }
    end
  end

  def show
    @skill_set = SkillSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skill_set }
    end
  end

  def new
    @skill_set = SkillSet.new
    render :layout => false
  end

  def edit
    @skill_set = SkillSet.find(params[:id])
    render :layout => false
  end

  def create
    @skill_set = SkillSet.new(params[:skill_set])
    
    @skill_set.user_id = current_user.id
    @skill_set.expertise_level_id = SkillSet.get_expertise_level_id(params[:skill_set][:expertise_level])
    @skill_set.save
    
    SkillCategory.new.first_or_create(params[:skill_set][:category])
    
    @user = current_user
    if request.protocol + request.host_with_port + "/" + current_user.profile_name == request.referer
      respond_to do |format|
         if session[:return_to].nil?
          format.html {redirect_to profile_path ,  :notice => "Don't forget to publish your changes by clicking on Create Pixsume button"}
        else
          @c = session[:return_to]
          session[:return_to]=nil
          format.html{redirect_to @c}
        end  
      end   
    else   
      respond_to do |format|
        format.js
      end   
    end

  end

  def update
    @skill_set = SkillSet.find(params[:id])
    @skill_set.expertise_level_id = SkillSet.get_expertise_level_id(params[:skill_set][:expertise_level])
    @skill_set.update_attributes(params[:skill_set])
    
    SkillCategory.new.first_or_create(params[:skill_set][:category])
    
    @user = current_user
  end

  def destroy
   
    @skill_set = SkillSet.find(params[:id])
    @skill_set.destroy
    @user = current_user
    redirect_to profile_path
  end

  def skillsetmap

    @user = current_user
    @search=[]
    @exact_match=[]
    @better_match=[]
    @all_matches=[]
    @other_skillsets=[]
    @skillsets=[]
    @search_match=[] 
    @skill_sets_user=[]
    @match_year_exact=[]
    @people_match=[]
    @skillsets_user=[]
    @skills=[]   
        
    if params[:designation].nil? 
      if params[:search].nil?
          @skills=current_user.skill_sets
          @designation=current_user.experiences
            @experience =current_user.experiences 
            @exp_desig=@experience.collect(&:designation)
        # calculate skillset through designation
          if !@designation.blank?
           
            @design=@designation.collect(&:designation)
            end
            if !@design.blank? 
            	@all_matches += Experience.find(:all ,:conditions=> ['designation LIKE ? AND user_id != ?', @design.last, current_user.id])
            end
        if !@all_matches.blank?
            @all_matches.each do |all_match|
              if !@designation.blank?
               
                if @designation.last.designation.downcase == all_match.designation.downcase
                  @match_year_exact << all_match
                end 
              end  
            end
      
            if !@match_year_exact.blank?
              @match_year_exact.each do |all_match|
                @user=User.find(all_match.user_id)
                @skill_sets_user += @user.skill_sets
                @people_match<< @user
              end
            end

            @uniq_category=@skills.collect{|s| ["#{s.category}", "#{s.user_id}"]}.uniq
              
            if !@skills.blank?          
              @skills.each do |skill|
                if @skill_sets_user.collect(&:name).include?(skill.name) == true 
                  @search << skill
                else
                  
                  @other_skillsets << skill
                end
              end    
            end 

            @search_match=@search.collect{|s| ["#{s.name}", "#{s.expertise_level_id}","#{s.id}"]}.uniq
            @user_unique_skillsets=@other_skillsets.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}.uniq              
            @user_remain_skillset = @skills.collect(&:name) - @skill_sets_user.collect(&:name).uniq
            
            #@user_skillsets=@skill_sets_user.collect(&:name).uniq
            @user_skillsets = @skill_sets_user.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}
            @user_skillsets1 = @skill_sets_user.collect(&:id)
            
            #@user_skillsets_missing=@user_skillsets-@skills.collect(&:name)
           
            
            @user_skillsets_missing = @user_skillsets.uniq{|s| s.first}
                       
            @count = 0             
            if !@search.blank?
              @search.each do |search_match|                     
                if search_match.expertise_level_id >=3
                  @count = @count+1 
                end  
              end  
            end  

            @score_better=0
            if !@other_skillsets.blank?
              @other_skillsets.each do |other_skillset|
                if other_skillset.expertise_level_id >=3
                  @score_better=@score_better+1
                end  
              end  
            end  

             
            if !@skills.blank?
              @overall_percent = ((@score_better+@count)*100/@skills.count)
            end
            # End of Overall score
        end    
        
        @missing_suggestion= @user_unique_skillsets
        @search_suggestion=@search_match
      else  
        # @skills=current_user.skill_sets
        @designation=current_user.experiences
      # start calculation of search through name of user you can enter.
          @user=User.where('name LIKE ?', "#{params[:search]}%")
          
          if !@user.blank?

            @skills_set=current_user.skill_sets
            @skills_set.each do |skills_set|
              skills_set.name=skills_set.name.downcase
              @skills << skills_set
            end
          
            @user.each do |user|
              @skillsets_user += user.skill_sets
            end

            @people_match<<@user
            @skillsets_user.each do |skill_user|
              skill_user.name = skill_user.name.downcase
              @skillsets << skill_user
            end
      
            if !@skills.blank?
              
              @skills.each do |skill|

                if @skillsets.collect(&:name).include?(skill.name) != true
                  @other_skillsets << skill
                else
                  @search_match << skill
                end   
              end
            end 

            @user_skillsets=@skillsets.collect(&:name).uniq

            # overall score calculate indiviual 
              @scores=@skills.collect(&:name)-@search_match.collect(&:name).uniq
              @count1=0
              #@user_skillsets=@skillsets.collect(&:name).uniq
              @user_skillsets=@skillsets.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}.uniq

              @user_skillsets_missing=@user_skillsets-@skills.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}.uniq
            
              if !@search_match.blank?
                 
                @search_match.each do |search_match|                     
                  if search_match.expertise_level_id >=3
                    @count1 = @count1+1 
                  end  
                end  
              end  

              @score_better=0
              if !@other_skillsets.blank?
                @other_skillsets.each do |other_skillset|
                  if other_skillset.expertise_level_id >=3
                    @score_better=@score_better+1
                  end  
                end  
              end  

              if !@skills.blank? 
                @overall_percent = ((@score_better+@count1)*100/@skills.count)
              end            
            # end of overall
            
            @search_match = @search_match.collect{|s| ["#{s.name}", "#{s.expertise_level_id}","#{s.id}"]}.uniq
            
            if !@other_skillsets.blank?  
              @user_unique_skillsets=@other_skillsets.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}.uniq
            end
          end
      end  
      #end of search through user name
    else
      #start skill calculation when user suggest our own designation
        
        @experience =current_user.experiences
        @exp_desig=@experience.collect(&:designation)
        @experience_desig=@exp_desig.last
        @experience_title=Experience.where('designation LIKE ?', "#{params[:designation]}%")
           
        @current_user_experiences=Experience.find(:all, :conditions => ['user_id= ?' , current_user.id] )
        @match_year_exact=[]
        # calculate exact match according to its experience year
        if !@experience_title.blank?
          @experience_title.each do |experience_title|
            @current_user_experiences.each do |exp|
             
              if exp.designation.downcase == experience_title.designation.downcase
                if current_user.id != experience_title.user_id
                  @match_year_exact << experience_title
                end 
              end   
            end
          end 
        end  

        # end of exact match through year
        @skillset_perfect=[]
        if !@experience_title.blank?
          @experience_title.each do |experience_title|
            @user = User.find(experience_title.user_id)
	    if @user.id != current_user.id
              @skillsets += @user.skill_sets
              @people_match<< @user
            end
          end
        end        
       
        @match_user_skillset = []
        @skills=current_user.skill_sets   
          if !@skills.blank?
            @skills.each do |skill|

              if @skillsets.collect(&:name).include?(skill.name) != true
                @other_skillsets << skill
              else
                @match_user_skillset << skill
              end   
            end
          end  
        
        #@search_match =@match_user_skillset.collect{|s| ["#{s.name}", "#{s.expertise_level_id}"]}.uniq
        @search_match =@match_user_skillset.collect{|s| ["#{s.name}", "#{s.expertise_level_id}","#{s.id}"]}.uniq
        # @user_unique_skillsets=@other_skillsets.collect(&:name).uniq 
         @user_unique_skillsets=@other_skillsets.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}.uniq
      
        #@user_remain_skillset = @skills.collect(&:name) - @skillset_perfect.collect(&:name).uniq
        @user_remain_skillset = @skills.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}.uniq - @skillset_perfect.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}.uniq
      
        @user_skillsets=@skillsets.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}.uniq
        #@user_skillsets_missing=@user_skillsets-@skills.collect(&:name)
        @user_skillsets_missing=@user_skillsets-@skills.collect{|s| ["#{s.name.downcase}", "#{s.id}"]}.uniq

        @count3 = 0
          if !@match_user_skillset.blank?                 
            @match_user_skillset.each do |search_match|                     
              if search_match.expertise_level_id >=3
                @count3 = @count3+1 
              end  
            end  
          end  

          @score_better=0
          if !@other_skillsets.blank?
            @other_skillsets.each do |other_skillset|
              if other_skillset.expertise_level_id >=3
                @score_better=@score_better+1
              end  
            end  
          end  
      
        if !@skills.blank?
          @overall_percent = ((@score_better+@count3)*100/@skills.count)
        end
    end  
  end

  def user_search
    if !params[:data].blank?
     @users=User.where('name LIKE ?', "#{params[:data]}%").collect(&:name)
    end
  end

  def experience_search
    if !params[:data].blank?
      @skillset_title=Experience.where('designation LIKE ?', "#{params[:data]}%").collect(&:designation)
    end
  end

  def add_resource

    @resource= Resource.new
  end

  def resource_create
    
    #@resource = Resource.new(params[:resource])
    @resource= Resource.new
    @resource.name= params[:resource][:name]
    @resource.resource_name=params[:resource][:resource_name]
    @resource.description=params[:resource][:description]
    @resource.logo=params[:resource][:logo]
    @resource.paid=params[:resource][:paid]
    @resource.link=params[:resource][:link]

    @resource.user_id = current_user.id
    @resource.source  = current_user.name
    @resource.skill_set_id=params[:skill_set].to_i  

    if @resource.save
       if !params[:url].include?current_user.profile_name

       session[:resource]="resource"
       redirect_to skillsetmap_skill_sets_path
       else
        session[:res]="res"
        redirect_to pixsume_path
       end 
    else
      
      redirect_to request.referrer ,:notice=>"Please give valid link use http or https"
    end   
  end

  def show_resource

    if params[:data].nil?
      @resources=Resource.all.sort_by{|e| e[:resource_name].downcase}
    else  
      if params[:data]=="resource name"
   
        @resources=Resource.all.sort_by{|e| e[:resource_name].downcase}
      end  
      if params[:data] == "skill set name"
        @resources=Resource.all.sort_by{|e| e[:name]}
      end
      if params[:data] == "status"
        @resources=[]
        @resource1=Resource.find(:all,:conditions=> ['approved= ?' , true])
        @resource2=Resource.all
        @resource2.each do |resource|
          if !@resource1.collect(&:id).include?(resource.id)
            @resources << resource
          end
        end
      end
      if params[:data]=="Please select"
        @resources=Resource.order("id DESC").all
      end
    
    if !params[:search_str].blank?
      
      if params[:data]=="skill set name"
         @resources=Resource.where('name like ?', "%#{params[:search_str]}%")
      elsif params[:data] == "resource name" || params[:data].nil?
         @resources=Resource.where('resource_name like ?', "%#{params[:search_str]}%")
     
      end

    end

      respond_to do |format|
        
        format.js
      end
    end  

  end

  def approved_resource
    @resource=Resource.find(params[:format].to_i)
    @resource.approved=false

    if @resource.save
      redirect_to resources_path, notice: 'Resource pending successfully.'
    end
  end  

  def pending_resource

    @resource=Resource.find(params[:format].to_i)
    @resource.approved=true
    
    if @resource.save
      redirect_to resources_path, notice: 'Resource approved successfully.'
    end
  end

  def add_requestor

    @user=current_user
    @requestor = Requestor.new
    @requestor.requestor_name=@user.name
    @requestor.requestor_email=@user.email
    @requestor.user_id=@user.id
    @requestor.skill_set_id=params[:id].to_i
    @requestor.requested_date = Date.today
   
    if @requestor.save
      if request.referrer != request.protocol+request.host_with_port+"/"+current_user.profile_name
       #session[:requestor]="requestor"
      # redirect_to skillsetmap_skill_sets_path 
    else
      session[:req]="req"
      redirect_to pixsume_path
    end
    else
      redirect_to request.referer ,:notice=>"Please give valid entry"
    end
  end

  def resource_available
    
    @resources=Resource.find(:all,:conditions=>['skill_set_id=? AND approved= ?' ,params[:data],true])
    respond_to do |format|
      format.js
    end
  end

  def resource_detail

    @resource=Resource.find(params[:id])
   
  end

  def resource_sort


  end
  def checked_popup
    
    if !params[:check].nil?
      @user=current_user
      @user.checked=true
      @user.save
    end
    redirect_to skillsetmap_skill_sets_path
  end

  def show_requestor
    @requestors=Requestor.order("id DESC").all
  end
  def edit_resource
    @resource=Resource.find(params[:resource_id])
  
  end
  def update_resource
   
    @resource= Resource.find(params[:id].to_i)
    @resource.name= params[:resource][:name]
    @resource.resource_name=params[:resource][:resource_name]
    @resource.description=params[:resource][:description]
    @resource.logo=params[:resource][:logo]
    @resource.paid=params[:resource][:paid]
    @resource.link=params[:resource][:link]

    @resource.user_id = current_user.id
    @resource.source  = current_user.name
    @resource.skill_set_id=params[:skill_set].to_i  

    if @resource.save
      
       if !params[:url].include?current_user.profile_name

       session[:resource]="updated"
       redirect_to resources_path
       else
        session[:res]="res"
        redirect_to pixsume_path
       end 
    else
      
      redirect_to request.referrer ,:notice=>"Please give valid link use http or https"
    end   
  end

end



