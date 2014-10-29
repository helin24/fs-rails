class UsersSkillsController < ApplicationController
	def show
		@users_skill = UsersSkill.find_by_id(params[:id])
		user = @users_skill.user

		# redirect if user skill is not current user's or current user's student
		if user != current_user && !current_user.coach_of?(user)
			@users_skill = UsersSkill.find_by(skill: @users_skill.skill, user: current_user)
			redirect_to users_skill_path(@users_skill)
		end

		@note = Note.new
		@public_notes = @users_skill.skill.notes.where(public: 1)
			.where.not(notable_id: @users_skill.id)
	end
end
