class FieldMovesSkill < ActiveRecord::Base
	belongs_to :field_move
	belongs_to :skill
end
