class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			sign_in(user)
			redirect_to url_for(controller: :users, action: :show, id: user.id)
		else
			flash.now[:error] = "Invalid email/password combination"
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to home_path
	end
	
end
