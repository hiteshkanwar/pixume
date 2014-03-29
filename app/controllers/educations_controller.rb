class EducationsController < ApplicationController
  def new
    @education = Education.new
    render :layout => false
  end
  
  def create
    @education = Education.new params[:education]
    @education.user_id = current_user.id
    @education.save

    SchoolRating.new.first_or_create(params[:education][:institute])
    CourseRating.new.first_or_create(params[:education][:course])

    @user = current_user
  end
  
  def edit
    @education = Education.find params[:id]
    render :layout => false
  end
  
  def update
    @education = Education.find params[:id]
    @education.update_attributes(params[:education])
    @user = current_user

    SchoolRating.new.first_or_create(params[:education][:institute])
    CourseRating.new.first_or_create(params[:education][:course])

    render 'create'
  end
  
  def destroy
    @education = Education.find params[:id]
    @education.destroy
    @user = current_user
  end
end
