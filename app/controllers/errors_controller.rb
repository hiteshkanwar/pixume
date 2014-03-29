class ErrorsController < ApplicationController
  def routing
  	
  	# previous_url=session[:previous_url]
  	# mail_id=current_user.email
  	# user=current_user
  	# accessed_url=request.original_url
  	# action=session[:event]
  	#UserMailer.user_error_send_mail(mail_id,user,accessed_url,previous_url,action).deliver
  
   render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end

