class CoachingsController < ApplicationController
	def update
		coaching = Coaching.find(params[:id])
		if params[:coaching][:skater_confirmed] == "true"
			coaching.update(skater_confirmed: true)
		elsif params[:coaching][:coach_confirmed] == "true"
			coaching.update(coach_confirmed: true)
		else
			coaching.destroy
		end
		redirect_to current_user
	end

	def create
		coaching = Coaching.create(strong_params)
		if coaching.coach_confirmed
			user = coaching.skater
		elsif coaching.skater_confirmed
			user = coaching.coach
		end
		redirect_to user
	end

	def strong_params
		params.require(:coaching).permit(:coach_id, :skater_id, :coach_confirmed, :skater_confirmed)
	end
end
