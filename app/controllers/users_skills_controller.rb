class UsersSkillsController < ApplicationController
	def show
		@users_skill = UsersSkill.find_by(skill_id: params[:id], user_id: current_user.id)
	end
end
