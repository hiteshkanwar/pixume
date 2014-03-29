class JobPostingSkillSetsController < ApplicationController
  # GET /job_posting_skill_sets
  # GET /job_posting_skill_sets.json
  def index
    @job_posting_skill_sets = JobPostingSkillSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @job_posting_skill_sets }
    end
  end

  # GET /job_posting_skill_sets/1
  # GET /job_posting_skill_sets/1.json
  def show
    @job_posting_skill_set = JobPostingSkillSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job_posting_skill_set }
    end
  end

  # GET /job_posting_skill_sets/new
  # GET /job_posting_skill_sets/new.json
  def new
    @job_posting_skill_set = JobPostingSkillSet.new
    render :layout => false
  end

  # GET /job_posting_skill_sets/1/edit
  def edit
    @job_posting_skill_set = JobPostingSkillSet.find(params[:id])
    render :layout => false
  end

  # POST /job_posting_skill_sets
  # POST /job_posting_skill_sets.json
  def create
    @job_posting_skill_set = JobPostingSkillSet.new(params[:job_posting_skill_set])
    @job_posting_skill_set.save
    @user = current_user
  end

  # PUT /job_posting_skill_sets/1
  # PUT /job_posting_skill_sets/1.json
  def update
    @job_posting_skill_set = JobPostingSkillSet.find(params[:id])
    @job_posting_skill_set.update_attributes(params[:job_posting_skill_set])
    @user = current_user    
  end

  # DELETE /job_posting_skill_sets/1
  # DELETE /job_posting_skill_sets/1.json
  def destroy
    @job_posting_skill_set = JobPostingSkillSet.find(params[:id])
    @job_posting_skill_set.destroy
    @user = current_user
  end
end
