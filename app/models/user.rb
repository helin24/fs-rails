class User < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }	
	validates :password, length: {minimum: 6}

	before_create :create_remember_token
	has_secure_password

	before_save { self.email = email.downcase }
end
