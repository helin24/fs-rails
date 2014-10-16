class Skill < ActiveRecord::Base
	has_many :users_skills
	has_many :users, through: :users_skills
	belongs_to :level
	has_many :notes, through: :users_skills
end
