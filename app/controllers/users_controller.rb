class UsersController < ApplicationController
	def show 
		@user = User.find(params[:id])
		#debugger - useful for testing state of prog
	end

	def new 
		@user = User.new

	end
	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user #login upon sign up
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else 
			flash.now[:danger] = "There are some errors with your submission!"
			render 'new'
			
		end
	end


private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

end

