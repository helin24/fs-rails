class UsersLevelsController < ApplicationController
	def show
		@users_level = UsersLevel.find_by(level_id: params[:id], user_id: current_user.id)
	end
end
