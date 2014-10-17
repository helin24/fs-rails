class UsersLevelsController < ApplicationController
	def show
		@users_level = UsersLevel.find_by(level_id: params[:id], user_id: current_user.id)
	end

	def update
		puts params
		@users_level = UsersLevel.find(params[:id])
		params[:users_skill_progress].each do |users_skill_id, progress|
			UsersSkill.find(users_skill_id).update(progress: progress)
		end
		@users_level.compute
		redirect_to users_level_path(@users_level.level)
	end
end
