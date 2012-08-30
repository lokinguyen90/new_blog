module SessionsHelper
	#create cookies
	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		self.current_user = user
	end

	# set current user
	def current_user=(user)
		@current_user = user
	end

	# return current user
	def current_user
		@current_user ||= user_from_remember_token
	end

	# check if signed in
	def signed_in?
		!current_user.nil?
	end

	# delete cookies
	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	# redirect illegal access
	def deny_access
		redirect_to signin_path, :notice => "Please sign in to access this page."
	end

	# check if current user is specified user
	def current_user?(user)
		@current_user == user
	end

	# check if user can access
	def authenticate
		deny_access unless signed_in?
	end
	
	private
		def user_from_remember_token
			User.authenticate_with_salt(*remember_token)
		end
		
		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
		end
end
