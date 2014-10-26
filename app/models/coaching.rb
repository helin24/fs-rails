class Coaching < ActiveRecord::Base
	belongs_to :coach, foreign_key: "coach_id", class_name: "User"
	belongs_to :skater, foreign_key: "skater_id", class_name: "User"
end
