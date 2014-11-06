class UsersFieldMovesController < ApplicationController
	def show
		@users_field_move = UsersFieldMove.find(params[:id])
		user = @users_field_move.user

		# redirect if user skill is not current user's or current user's student
		if user != current_user && !current_user.coach_of?(user)
			@users_field_move = UsersFieldMove.find_by(field_move: @users_field_move.field_move, user: current_user)
			redirect_to users_field_move_path(@users_field_move)
		end

		@public_notes = @users_field_move.field_move.notes.where(public: 1)
		.where.not(notable_id: @users_field_move.id)
		@note = Note.new
	end
end
