class NotesController < ApplicationController
	def new
		@note = Note.new
		render
	end

	def create
		Note.create(note_params)
		redirect_to users_skill_path(UsersSkill.find(note_params[:notable_id]))
	end

	def show
	end

	def edit
	end

	def update
	end

	def delete
	end

	private

		def note_params
			params.require(:note).permit(:text, :source, :public, :notable_type, :notable_id)
		end
end
