class Skill < ActiveRecord::Base
	has_many :users_skills
	has_many :users, through: :users_skills
	belongs_to :level
	has_many :notes, through: :users_skills

	has_many :field_moves_skills
	has_and_belongs_to_many :field_moves, through: :field_moves_skills

	has_many :elements, as: :elementable

	def group
		self.level
	end
end
