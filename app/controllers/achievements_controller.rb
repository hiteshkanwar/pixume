class AchievementsController < ApplicationController
  def index
    @achievement = Achievement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @achievement }
    end
  end

  def show
    @achievement = Achievement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @achievement }
    end
  end

  def new
    @achievement = Achievement.new
    render :layout => false
  end

  def create
    @achievement = Achievement.new params[:achievement]
    @achievement.user_id = current_user.id
    @achievement.save
    
    AchievementCategory.new.first_or_create(params[:achievement][:category])

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

  def edit
    @achievement = Achievement.find params[:id]
    render :layout => false
  end

  def update
    @achievement = Achievement.find params[:id]
    @achievement.update_attributes(params[:achievement])

    unless params[:achievement][:category].blank?
      AchievementCategory.new.first_or_create(params[:achievement][:category])
    end

    @user = current_user
    render 'create'
  end

  def destroy
    @achievement = Achievement.find params[:id]
    @achievement.destroy
    @user = current_user
    redirect_to profile_path
  end
end

