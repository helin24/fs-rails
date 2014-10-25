class CreateJoinTableFieldMovesSkills < ActiveRecord::Migration
  def change
  	create_table :field_moves_skills do |t|
  		t.references :skill, index: true
  		t.references :field_move, index: true
  	end
  end
end
