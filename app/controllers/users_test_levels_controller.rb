class UsersTestLevelsController < ApplicationController
	def show
		@users_test_level = UsersTestLevel.find(params[:id])
		user = @users_test_level.user

		if user != current_user && !current_user.coach_of?(user)
			@users_test_level = UsersTestLevel.find_by(test_level: @users_test_level.test_level, user: current_user)
			redirect_to users_test_level_path(@users_test_level)
		end
	end

	def update
		@users_test_level = UsersTestLevel.find(params[:id])
		params[:users_field_move_progress].each do |id, progress|
			UsersFieldMove.find(id).update(progress: progress)
		end

		@users_test_level.update(achieved_on: params[:users_test_level_achieved_on])

		@users_test_level.compute
		redirect_to @users_test_level
	end
end
