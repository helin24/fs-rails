class RoutinesController < ApplicationController
	def new
		@user = current_user
		@routine = Routine.new(length: 60)
		@all_groups = Level.all + TestLevel.all
		@all_elements = Skill.all + FieldMove.all
	end

	def create
		@routine = Routine.create(routine_params)
		render partial: "form", layout: false, locals: {routine: @routine}
	end

	private

		def routine_params
			params.require(:routine).permit(:name, :description, :author_id, :user_id, :length)
		end
end
