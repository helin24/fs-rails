class RoutinesController < ApplicationController
	def new
		@user = current_user
		@routine = Routine.new(length: 60)
		puts "routine id is #{@routine.id}"
		@all_groups = Level.all + TestLevel.all
		@all_elements = Skill.all + FieldMove.all
	end

	def create
		@routine = Routine.create(routine_params)
		render partial: "form", layout: false, locals: {routine: @routine}
	end

	def edit
		@user = current_user
		@routine = Routine.find(params[:id])
		@all_groups = Level.all + TestLevel.all
		@all_elements = Skill.all + FieldMove.all
		render "new"
	end

	def update
		@routine = Routine.update(routine_params)
		render partial: "form", layout: false, locals: {routine: @routine}
	end

	private

		def routine_params
			params.require(:routine).permit(:name, :description, :author_id, :user_id, :length)
		end
end
