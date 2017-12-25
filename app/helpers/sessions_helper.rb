module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id
	end
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end
	def logged_in? #called in views
		!current_user.nil?
	end
	def forget(user)
		user.forget #set token digest to nil
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end
	def log_out 
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end
	def remember(user)
		user.remember #store digest token
		cookies.permanent.signed[:user_id] = user.id #create cookies
		cookies.permanent[:remember_token] = user.remember_token #attribute of user
	end
end

#### Cookies 

#1) Associate a remember_token digest with a user, also 
#2) Put encrypted user_id and remember_token as cookies with long expiries in browser
#3) When presented with a cookie containing a persistent user id, find the user in the database 
#using the given id, and verify that the remember token cookie matches the associated hash digest from the database.
