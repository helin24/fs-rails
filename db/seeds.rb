require_relative '../app/models/level'
require_relative '../app/models/skill'
require 'csv'

Level.delete_all
Skill.delete_all
TestLevel.delete_all
FieldMove.delete_all

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

# This information is taken from USFSA PDF (updated yearly)

TestLevel.create(name: "Pre-Preliminary", standard_code: "PPM")
TestLevel.create(name: "Preliminary", standard_code: "PM")
TestLevel.create(name: "Pre-Juvenile", standard_code: "PJM")
TestLevel.create(name: "Juvenile", standard_code: "JM")
TestLevel.create(name: "Intermediate", standard_code: "IM")
TestLevel.create(name: "Novice", standard_code: "NM")
TestLevel.create(name: "Junior", standard_code: "JRM")
TestLevel.create(name: "Senior", standard_code: "SRM")
TestLevel.create(name: "Intermediate Supplemental", standard_code: "ISM")
TestLevel.create(name: "Senior Supplemental", standard_code: "SSM")
TestLevel.create(name: "Adult Pre-Bronze", standard_code: "APBM")
TestLevel.create(name: "Adult Bronze", standard_code: "ABM")
TestLevel.create(name: "Adult Silver", standard_code: "ASM")
TestLevel.create(name: "Adult Gold", standard_code: "AGM")

# PDF page number inputs

level_summary_page = 297 # page that provides a summary of test levels and standard codes
mitf_start_page = 299 # first page with MITF
mitf_end_page = 364 # last page
file = 'Rulebook20140814' # file should be saved in lib/assets


####### NEED TO REMIGRATE TEST LEVELS AND FIELD MOVES TABLES ###
def extract_description(text_lines, start_line)
	description = ""
	text_lines[start_line..-1].each do |line|
		if line == line.upcase && line != ""
			break
		else
			description << line.strip + " "
		end
	end
	description
end

# Field Moves
book = PDF::Reader.new('lib/assets/Rulebook20140814.pdf')

(mitf_start_page..mitf_end_page).each do |p|
	text_lines = book.page(p).text.split(/\n/)
	test_level_name = text_lines[0].match(/[\D]+/)[0].strip
	# test_level_name = text_lines.match(/[a-zA-Z-]+/)[0]
	title_line_num = 3
	field_move_name = ""
	text_lines[1..-1].each.with_index do |line, index|
		if line.match(/[a-zA-Z]/)
			puts "found title"
			title_line_num = index
			field_move_name = line.strip
			break
		end
	end

	puts "title line num is #{title_line_num} and field move name is #{field_move_name}"
	field_move_description = extract_description(text_lines, title_line_num + 2)
	FieldMove.create(name: field_move_name, test_level_id: TestLevel.find_by(name: test_level_name).id, description: field_move_description)
end
