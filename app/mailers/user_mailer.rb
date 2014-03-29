class UserMailer < ActionMailer::Base

	def user_send_mail(mail_id,user)
    if !mail_id.nil?
        @mail_id=mail_id
        @user=user
     		@url='107.170.114.144'
        mail :subject =>"#{user.name} invites you to join Pixsume.",
	        :to => mail_id,
	        :from    => Pixsume  
    end
  end


	def user_send_mail_individual(user,params)
	  if !params[:search1].blank?
	    @email=params[:search1]
	    @user=user
	    @url='107.170.114.144'
	    
	    mail :subject =>"#{user.name} invites you to join Pixsume.",
	       :to => @email,
	       :from    => Pixsume
		end
  end

	def user_error_send_mail(mail_id,user,accessed_url,previous_url,action)
	    if !mail_id.nil?
	        @mail_id=mail_id
	        @user=user
	        @previous_url=previous_url
	        @accessed_url=accessed_url
	        @action=action
	     	@url='107.170.114.144'
	        mail :subject =>"Pixsume Error Message.",
		        :to => 'support@pixsume.com',
		        :from    => Pixsume  
	    end
	 end



	def welcome(user)
		@user = user
		
		mail(to: @user.email, from: Pixsume, subject: 'Welcome to Pixsume')
	end

end
