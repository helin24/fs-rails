class CreateCoachings < ActiveRecord::Migration
  def change
    create_table :coachings do |t|
    	t.references :skater
    	t.references :coach
    	t.date :relationship_began
      t.timestamps
    end
  end
end
