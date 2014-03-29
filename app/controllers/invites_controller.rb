class InvitesController < ApplicationController
    def index
       @contacts = request.env['omnicontacts.contacts']
          if request.fullpath.include? "gmail"
    	     @from_gmail = "true"
    	   end 
          if request.fullpath.include? "yahoo"
    		@from_gmail = "true"
    	  end
	  if !@contacts.blank?
	    session[:contact] = @contacts	     
	  end		
    
	@users_email=[]
	if !session[:contact].blank?
	   if !params[:data].nil?	
	      session[:contact].each do |contact|
		 @users_email <<  "#{contact[:email]}"
	      end	
              @user_email=@users_email.select {|s| s.include? params[:data]}
          end	
	end
		
	respond_to do |format|
	   if @user_email.blank?
	      format.html 
	   else
	      format.js	 
	   end   
	end
     end

     def user_send_mail
	user=current_user
	if !params[:user_all].blank?
		params[:user_all].each do |mail_id|
          UserMailer.user_send_mail(mail_id,user).deliver
        end
        redirect_to skillsetmap_skill_sets_path,:notice=>"We have successfully send the invites."
    elsif !params[:search1].blank? 
      UserMailer.user_send_mail_individual(user,params).deliver
      redirect_to skillsetmap_skill_sets_path,:notice=>"We have successfully send the invite."
    else
      redirect_to skillsetmap_skill_sets_path 	
    end 	
    end	
end
