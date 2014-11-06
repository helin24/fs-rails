class UsersTestLevel < ActiveRecord::Base
	belongs_to :user
	belongs_to :test_level
	has_many :users_field_moves
	has_many :notes, as: :notable

	def compute
		self.learned_points = self.users_field_moves.sum(:progress)
		self.total_points = self.users_field_moves.count * UsersFieldMove.max_progress
		self.save
	end
end
