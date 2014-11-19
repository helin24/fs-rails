class RoutinesController < ApplicationController
	def new
		@user = current_user
		@routine = Routine.new(length: 60)
		puts "routine id is #{@routine.id}"
		@all_groups = Level.all + TestLevel.all
		@all_elements = Skill.all + FieldMove.all
		render 'show'
	end

	def create
		@routine = Routine.create(routine_params)
		elements = JSON.parse(params["routine_elements"])["elements"]
		elements.each do |elem|
			Element.create(elementable_type: elem["elementable_type"], elementable_id: elem["elementable_id"], routine_id: @routine.id, top: elem["top"], left: elem["left"])
		end
		render partial: "form", layout: false, locals: {routine: @routine}
	end

	def edit
		@user = current_user
		@routine = Routine.find(params[:id])
		@all_groups = Level.all + TestLevel.all
		@all_elements = Skill.all + FieldMove.all
		@routine_elements = @routine.elements
		render "show"
	end

	def update
		id = routine_params[:id]
		@routine = Routine.find(id)
		@routine.update(routine_params)
		elements = JSON.parse(params["routine_elements"])["elements"]
		elements.each do |elem|
			found_element = Element.find_by(id: elem["id"])
			if found_element
				found_element.update(elementable_type: elem["elementable_type"], elementable_id: elem["elementable_id"], routine_id: @routine.id, top: elem["top"], left: elem["left"])
			else
				Element.create(elementable_type: elem["elementable_type"], elementable_id: elem["elementable_id"], routine_id: @routine.id, top: elem["top"], left: elem["left"])
			end
		end
		render partial: "form", layout: false, locals: {routine: @routine}
	end

	private

		def routine_params
			params.require(:routine).permit(:name, :description, :author_id, :user_id, :length, :id)
		end
end
