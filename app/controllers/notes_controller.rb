class NotesController < ApplicationController
	def new
		@note = Note.new
	end

	def create
		Note.create(note_params)
		redirect_to users_skill_path(UsersSkill.find(note_params[:notable_id]))
	end

	def show
	end

	def edit
		@note = Note.find(params[:id])
	end

	def update
		puts params
		@note = Note.find(params[:id])
		@note.update(note_params)
		render json: @note
	end

	def destroy
		@note = Note.find(params[:id])
		@note_owner = @note.notable
		@note.destroy
		redirect_to @note_owner
	end

	private

		def note_params
			params.require(:note).permit(:text, :source, :public, :notable_type, :notable_id)
		end
end
