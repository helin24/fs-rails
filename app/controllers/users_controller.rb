class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in(@user)
			redirect_to :show, @user
		else
			flash.now[:error] = "Try again"
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :about, :birthday, :password, :password_confirmation)
	end

end
