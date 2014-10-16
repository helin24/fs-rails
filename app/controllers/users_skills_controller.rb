class UsersSkillsController < ApplicationController
	def show
		@users_skill = UsersSkill.find_by(skill_id: params[:id], user_id: current_user.id)
		@note = Note.new
		@public_notes = Skill.find(params[:id]).notes.where(public: 1)
			.where.not(notable_id: @users_skill.id)
	end
end
