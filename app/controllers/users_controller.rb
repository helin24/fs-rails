class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in(@user)
			redirect_to action: "show", id: current_user.id
		else
			flash.now[:error] = "Try again"
			render 'new'
		end
	end

	def show
		puts params
		@user = User.find(params[:id])
		@levels = Level.all
	end

	def edit
		@user = User.find(params[:id])
		if @user == current_user
			render 'edit'
		else
			redirect_to action: "show", id: current_user.id
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to action: "show", id: current_user.id
		else
			flash.now[:error] = "Try again"
			render 'edit'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :about, :birthday, :password, :password_confirmation, :started_skating)
	end

end
