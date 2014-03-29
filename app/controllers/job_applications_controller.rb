class JobApplicationsController < ApplicationController
	skip_before_filter :authenticate_user! # ver 1.0

	def create
		
		require 'money'
		
		if logged_in?
			
			@jobs=current_user.job_applications.collect(&:job_posting_id)
		  	if @jobs.include?(params[:job_posting_id].to_i)
           			@values="applied"     
		    else
			  	
					@job_application = JobApplication.new
					@job_application.job_posting_id = params[:job_posting_id]
					@job_application.user_id = params[:user_id]
					@job_application.availablity=params[:availablity].to_i
					@job_application.expected_salary=params[:expected_salary].to_i
					@job_application.best_fit_for_job=params[:best_fit_for_job]
					if !params[:currency].blank? 
					@job_application.currency=params[:currency]  
					else
					@job_application.currency="$"
					end       
				   	@job_application.save
				 	if !params[:file].blank?
						@file=current_user.resume_files.create(:file=>params[:file])
						@file.job_application_id=@job_application.id
						@file.save
					end	
			end		
		end
		
		if !params[:flag].nil?
      		session[:flag]="true"
   		end
   		
   		if !params[:file].nil?
   			
		 	redirect_to job_posting_path(params[:job_posting_id].to_i,:@values=>@values)
   	   	else
   			
	   		respond_to do |format|
	  			format.js
			end
		end
		
	end
end




