require_relative '../app/models/level'
require_relative '../app/models/skill'
require 'csv'

Level.delete_all
Skill.delete_all

Level.create(name: 'Pre-Alpha', organization: 'ISI')
Level.create(name: 'Alpha', organization: 'ISI')
Level.create(name: 'Beta', organization: 'ISI')
Level.create(name: 'Gamma', organization: 'ISI')
Level.create(name: 'Delta', organization: 'ISI')
Level.create(name: 'Freestyle 1', organization: 'ISI')
Level.create(name: 'Freestyle 2', organization: 'ISI')
Level.create(name: 'Freestyle 3', organization: 'ISI')
Level.create(name: 'Freestyle 4', organization: 'ISI')
Level.create(name: 'Freestyle 5', organization: 'ISI')
Level.create(name: 'Freestyle 6', organization: 'ISI')
Level.create(name: 'Freestyle 7', organization: 'ISI')
Level.create(name: 'Freestyle 8', organization: 'ISI')
Level.create(name: 'Freestyle 9', organization: 'ISI')
Level.create(name: 'Freestyle 10', organization: 'ISI')

# Individual skills
CSV.foreach('lib/assets/skills.csv', headers: true) do |row|
	skill = Skill.create(name: row['skill'])
  puts row['skill']
  puts row['level']
	skill.level = Level.find_by(name: row['level'])
	skill.save
end

# Test Levels
# Need more research on this anyway

# Field Moves