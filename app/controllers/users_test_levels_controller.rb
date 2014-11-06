class UsersTestLevelsController < ApplicationController
	def show
		@users_test_level = UsersTestLevel.find(params[:id])
	end
end
