class UsersTestLevelsController < ApplicationController
	def show
		@users_test_level = UsersTestLevel.find(params[:id])
		user = @users_test_level.user

		if user != current_user && !current_user.coach_of?(user)
			@users_test_level = UsersTestLevel.find_by(test_level: @users_test_level.test_level, user: current_user)
			redirect_to users_test_level_path(@users_test_level)
		end

	end
end
