class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }	
	validates :password, length: {minimum: 6}, if: :password

	has_many :notes

	has_many :skater_coachings, foreign_key: :coach_id, class_name: "Coaching"
	has_many :skaters, through: :skater_coachings, source: :skater
	has_many :coach_coachings, foreign_key: :skater_id, class_name: "Coaching"
	has_many :coaches, through: :coach_coachings, source: :coach

	has_many :users_skills
	has_many :skills, through: :users_skills
	has_many :users_levels
	has_many :levels, through: :users_levels

	has_many :users_test_levels
	has_many :test_levels, through: :users_test_levels
	has_many :users_field_moves
	has_many :field_moves, through: :users_field_moves

	has_many :routines

	before_create :create_remember_token
	has_secure_password

	before_save { self.email = email.downcase }
	after_create :add_levels, :add_skills, :relate_skills_levels, :add_test_levels, :add_field_moves, :relate_moves_tests

	def self.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def self.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def add_levels
		self.levels << Level.all
	end

	def add_skills
		self.skills << Skill.all
	end

	def add_test_levels
		self.test_levels << TestLevel.all
	end

	def add_field_moves
		self.field_moves << FieldMove.all
	end

	def relate_skills_levels
		self.users_levels.each do |users_level|
			users_level.users_skills << users_level.level.skills.map{|s| s.users_skills.where(user_id: self.id)}
			users_level.compute
		end
	end

	def relate_moves_tests
		self.users_test_levels.each do |users_test_level|
			users_test_level.users_field_moves << users_test_level.test_level.field_moves.map{|fm| fm.users_field_moves.where(user_id: self.id)}
			users_test_level.compute
		end
	end

	def coach_of?(skater)
		self.skater_coachings.find_by(skater: skater, skater_confirmed: true, coach_confirmed: true)
	end
	
	private
		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
