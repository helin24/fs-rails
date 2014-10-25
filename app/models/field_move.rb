class FieldMove < ActiveRecord::Base
	has_many :field_moves_skills
	has_and_belongs_to_many :skills, through: :field_moves_skills
end
