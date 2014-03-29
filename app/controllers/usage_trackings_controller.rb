class UsageTrackingsController < ApplicationController
  # GET /usage_trackings
  # GET /usage_trackings.json
  def index
    @usage_trackings = UsageTracking.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usage_trackings }
    end
  end

  # GET /usage_trackings/1
  # GET /usage_trackings/1.json
  def show
    @usage_tracking = UsageTracking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usage_tracking }
    end
  end

  # GET /usage_trackings/new
  # GET /usage_trackings/new.json
  def new
    @usage_tracking = UsageTracking.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usage_tracking }
    end
  end

  # GET /usage_trackings/1/edit
  def edit
    @usage_tracking = UsageTracking.find(params[:id])
  end

  # POST /usage_trackings
  # POST /usage_trackings.json
  def create
    @usage_tracking = UsageTracking.new(params[:usage_tracking])

    respond_to do |format|
      if @usage_tracking.save
        format.html { redirect_to @usage_tracking, notice: 'Usage tracking was successfully created.' }
        format.json { render json: @usage_tracking, status: :created, location: @usage_tracking }
      else
        format.html { render action: "new" }
        format.json { render json: @usage_tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /usage_trackings/1
  # PUT /usage_trackings/1.json
  def update
    @usage_tracking = UsageTracking.find(params[:id])

    respond_to do |format|
      if @usage_tracking.update_attributes(params[:usage_tracking])
        format.html { redirect_to @usage_tracking, notice: 'Usage tracking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usage_tracking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usage_trackings/1
  # DELETE /usage_trackings/1.json
  def destroy
    @usage_tracking = UsageTracking.find(params[:id])
    @usage_tracking.destroy

    respond_to do |format|
      format.html { redirect_to usage_trackings_url }
      format.json { head :no_content }
    end
  end
end
