class UsersTestLevel < ActiveRecord::Base
	belongs_to :user
	belongs_to :test_level
	has_many :users_field_moves
	has_many :notes, as: :notable

	# add amount of progress?
end
