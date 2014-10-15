class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }	
	validates :password, length: {minimum: 6}, if: :password

	has_many :users_skills
	has_many :skills, through: :users_skills
	has_many :users_levels
	has_many :levels, through: :users_levels

	before_create :create_remember_token
	has_secure_password

	before_save { self.email = email.downcase }
	after_create :add_levels, :add_skills, :relate_skills_levels

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

	def relate_skills_levels
		self.users_levels.each do |users_level|
			users_level.users_skills << users_level.level.skills.map{|s| s.users_skills.where(user_id: self.id)}
			users_level.compute
		end
	end
	
	private
		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
