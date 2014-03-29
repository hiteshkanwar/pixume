class ExperiencesController < ApplicationController
  def new
    @experience = Experience.new
    render :layout => false
  end
  
  def create 
    @experience = Experience.new params[:experience]
    @experience.user_id = current_user.id
    @experience.save
    @user = current_user
    @experiences = current_user.experiences
  end
  
  def edit
    @experience = Experience.find params[:id]
    render :layout => false
  end
  
  def update
    @experience = Experience.find params[:id]
    @experience.update_attributes(params[:experience])
    @user = current_user
    @experiences = current_user.experiences
    render :create
  end
  
  def destroy
    @experience = Experience.find params[:id]
    @experience.destroy
    @user = current_user
    respond_to do |format|
      format.js
    end
  end
  
end
