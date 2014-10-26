class CoachingsController < ApplicationController
	def update
		coaching = Coaching.find(params[:id])
		coaching.update(params[:coaching])
		redirect_to current_user
	end
end
