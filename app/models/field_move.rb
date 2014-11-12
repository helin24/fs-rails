class FieldMove < ActiveRecord::Base
	has_many :users, through: :users_field_moves
	belongs_to :test_level
	
	has_many :users_field_moves
	has_many :notes, through: :users_field_moves
	
	has_many :field_moves_skills
	has_and_belongs_to_many :skills, through: :field_moves_skills

	has_many :elements, as: :elementable

	def group
		self.test_level
	end
end
