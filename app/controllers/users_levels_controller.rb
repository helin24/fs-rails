class UsersLevelsController < ApplicationController
	def show
		@users_level = UsersLevel.find_by_id(params[:id])
		user = @users_level.user

		if user != current_user && !current_user.coach_of?(user)
			@users_level = UsersLevel.find_by(level: @users_level.level, user: current_user)
			redirect_to users_level_path(@users_level)
		end
	end

	def update
		@users_level = UsersLevel.find(params[:id])
		params[:users_skill_progress].each do |users_skill_id, progress|
			UsersSkill.find(users_skill_id).update(progress: progress)
		end
		@users_level.compute
		redirect_to users_level_path(@users_level)
	end

end
