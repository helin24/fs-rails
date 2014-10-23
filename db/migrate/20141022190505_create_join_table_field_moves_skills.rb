class CreateJoinTableFieldMovesSkills < ActiveRecord::Migration
  def change
  	create_table :field_moves_skills do |t|
  		t.references :skills, index: true
  		t.references :field_moves, index: true
  	end
  end
end
