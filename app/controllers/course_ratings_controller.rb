class CourseRatingsController < ApplicationController
  # GET /course_ratings
  # GET /course_ratings.json
  def index
    @course_ratings = CourseRating.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_ratings }
    end
  end

  # GET /course_ratings/1
  # GET /course_ratings/1.json
  def show
    @course_rating = CourseRating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_rating }
    end
  end

  # GET /course_ratings/new
  # GET /course_ratings/new.json
  def new
    @course_rating = CourseRating.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_rating }
    end
  end

  # GET /course_ratings/1/edit
  def edit
    @course_rating = CourseRating.find(params[:id])
  end

  # POST /course_ratings
  # POST /course_ratings.json
  def create
    @course_rating = CourseRating.new(params[:course_rating])

    respond_to do |format|
      if @course_rating.save
        format.html { redirect_to @course_rating, notice: 'Course rating was successfully created.' }
        format.json { render json: @course_rating, status: :created, location: @course_rating }
      else
        format.html { render action: "new" }
        format.json { render json: @course_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_ratings/1
  # PUT /course_ratings/1.json
  def update
    @course_rating = CourseRating.find(params[:id])

    respond_to do |format|
      if @course_rating.update_attributes(params[:course_rating])
        format.html { redirect_to @course_rating, notice: 'Course rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_ratings/1
  # DELETE /course_ratings/1.json
  def destroy
    @course_rating = CourseRating.find(params[:id])
    @course_rating.destroy

    respond_to do |format|
      format.html { redirect_to course_ratings_url }
      format.json { head :no_content }
    end
  end
end
