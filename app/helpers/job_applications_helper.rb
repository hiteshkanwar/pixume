module JobApplicationsHelper
	# 1.0 starts
		def show_apply_button(user)
			if !user 
				return true
			elsif user && user.role == 'admin' 
				return false
			elsif  user && user.role == 'recruiter'
				return false;
			end
			return true;
		end
	# 1.0 ends
end


