class RoutinesController < ApplicationController
	def new
		@user = current_user
		@routine = Routine.new(length: 60)
		@all_groups = Level.all + TestLevel.all
		@all_elements = Skill.all + FieldMove.all
	end

	def create
	end
end
