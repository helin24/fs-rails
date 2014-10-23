class UsersFieldMove < ActiveRecord::Base
	belongs_to :user
	belongs_to :field_move
	belongs_to :users_test_level
	has_many :notes, as: :notable

	def self.max_progress
		10
	end
end
