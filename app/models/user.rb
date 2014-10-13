class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }	
	validates :password, length: {minimum: 6}, if: :password

	has_many :users_skills
	has_many :skills, through: :users_skills

	before_create :create_remember_token
	has_secure_password

	before_save { self.email = email.downcase }
	before_save :add_skills

	def self.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def self.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def add_skills
		self.skills << Skill.all
	end
	
	private
		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
