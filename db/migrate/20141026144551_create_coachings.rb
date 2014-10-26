class CreateCoachings < ActiveRecord::Migration
  def change
    create_table :coachings do |t|
    	t.references :skater
    	t.references :coach
    	t.date :relationship_began
    	t.boolean :skater_confirmed, default: false
    	t.boolean :coach_confirmed, default: false

      t.timestamps
    end
  end
end
