class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
	before_action :correct_user,   only: [:edit, :update]
	before_action :admin_user,     only: :destroy

	def index 
		@users = User.paginate(page: params[:page])
	end

	def show 
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
		#debugger - useful for testing state of prog
	end

	def new 
		@user = User.new

	end
	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.account_activation(@user).deliver_now
			log_in(@user)
			flash[:info] = "A confirmation email has been sent to your address"
			redirect_back_or(@user)
		else @user
			render 'new'
			
		end
	end

	def edit 
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Changes Successful"
			redirect_to @user

		else
			render 'edit'
		end
	end

	def destroy 
		user = User.find(params[:id])
		if user == current_user #account deactivation
			user.destroy
			delete_username
			redirect_to root_path
			flash[:success] = "Your account has been deactivated"
		else 
			user.destroy #Admin delete
			flash[:success] = "User '#{session[:name]}' has been deleted"
			delete_username
			redirect_to users_url
		end

	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end



	def correct_user
		@user = User.find(params[:id])
		redirect_to root_path unless current_user?(@user)
	end

	def admin_user 
		user = User.find(params[:id])
		redirect_to root_path unless (current_user.admin? || user = current_user)

	end
end


