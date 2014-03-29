class SchoolRatingsController < ApplicationController
  # GET /school_ratings
  # GET /school_ratings.json
  def index
    @school_ratings = SchoolRating.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @school_ratings }
    end
  end

  # GET /school_ratings/1
  # GET /school_ratings/1.json
  def show
    @school_rating = SchoolRating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @school_rating }
    end
  end

  # GET /school_ratings/new
  # GET /school_ratings/new.json
  def new
    @school_rating = SchoolRating.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @school_rating }
    end
  end

  # GET /school_ratings/1/edit
  def edit
    @school_rating = SchoolRating.find(params[:id])
  end

  # POST /school_ratings
  # POST /school_ratings.json
  def create
    @school_rating = SchoolRating.new(params[:school_rating])

    respond_to do |format|
      if @school_rating.save
        format.html { redirect_to @school_rating, notice: 'School rating was successfully created.' }
        format.json { render json: @school_rating, status: :created, location: @school_rating }
      else
        format.html { render action: "new" }
        format.json { render json: @school_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /school_ratings/1
  # PUT /school_ratings/1.json
  def update
    @school_rating = SchoolRating.find(params[:id])

    respond_to do |format|
      if @school_rating.update_attributes(params[:school_rating])
        format.html { redirect_to @school_rating, notice: 'School rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @school_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_ratings/1
  # DELETE /school_ratings/1.json
  def destroy
    @school_rating = SchoolRating.find(params[:id])
    @school_rating.destroy

    respond_to do |format|
      format.html { redirect_to school_ratings_url }
      format.json { head :no_content }
    end
  end
end
