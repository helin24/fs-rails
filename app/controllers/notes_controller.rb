class NotesController < ApplicationController
	def new
		@note = Note.new
	end

	def create
		note = Note.create(note_params)
		render partial: "show", layout: false, locals: {note: note }
		# redirect_to users_skill_path(UsersSkill.find(note_params[:notable_id]))

		# how to have options depending on notable
		# right now requiring request to be from ajax
	end

	def show
	end

	def edit
		@note = Note.find(params[:id])
	end

	def update
		@note = Note.find(params[:id])
		@note.update(note_params)
		render json: @note
	end

	def destroy
		@note = Note.find(params[:id])
		@note_owner = @note.notable
		@note.destroy

		respond_to do |format|
			format.html { redirect_to @note_owner }
			format.js { head :ok }
		end
	end

	private

		def note_params
			params.require(:note).permit(:text, :source, :public, :notable_type, :notable_id, :user_id, :author_id)
		end
end
