class JobPostingsController < ApplicationController
 #skip_before_filter :authenticate_user!
  # GET /job_postings
  # GET /job_postings.json
  def index
    @job_postings = JobPosting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @job_postings }
    end
  end

  # GET /job_postings/1
  # GET /job_postings/1.json
  def show

    @job_posting = JobPosting.find(params[:id])
    @values=params[:@values]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job_posting }
    end
  
  end

  # GET /job_postings/new
  # GET /job_postings/new.json
  def new
    @job_posting = JobPosting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job_posting }
    end
  end

  # GET /job_postings/1/edit
  def edit
    @job_posting = JobPosting.find(params[:id])
  end

  # POST /job_postings
  # POST /job_postings.json
  def create
    @job_posting = JobPosting.new(params[:job_posting])
    @job_posting.company_id = current_user.company_id
    @job_posting.user_id = current_user.id

    flag = @job_posting.save

    skillsets = params[:keyskillsets].split(',')
    if flag && skillsets.blank? == false
      skillsets.each do |skillset|
        if skillset.blank? == false
          JobPostingSkillSet.new.first_or_create(@job_posting.id, skillset) 
        end
      end
    end

    respond_to do |format|
      if flag
        format.html { redirect_to @job_posting, notice: 'Job has been successfully posted.' }
        format.json { render json: @job_posting, status: :created, location: @job_posting }
      else
        format.html { render action: "new" }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
    @user = current_user
  end

  # PUT /job_postings/1
  # PUT /job_postings/1.json
  def update
    @job_posting = JobPosting.find(params[:id])
    @job_posting.company_id = current_user.company_id
    @job_posting.user_id = current_user.id

    flag = @job_posting.update_attributes(params[:job_posting])

    skillsets = params[:keyskillsets].split(',')
    if flag && skillsets.blank? == false
      skillsets.each do |skillset|
        if skillset.blank? == false
          JobPostingSkillSet.new.first_or_create(@job_posting.id, skillset)
        end
      end
    end

    respond_to do |format|
      if flag
        format.html { redirect_to @job_posting, notice: 'Job posting has been successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job_posting.errors, status: :unprocessable_entity }
      end
    end
    @user = current_user
  end

  # DELETE /job_postings/1
  # DELETE /job_postings/1.json
  def destroy
    @job_posting = JobPosting.find(params[:id])
    @job_posting.destroy

    respond_to do |format|
      format.html { redirect_to job_postings_url }
      format.json { head :no_content }
    end
    @user = current_user
  end
end
