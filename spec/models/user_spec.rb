require 'rails_helper'

describe "User" do 
	before do 
		@user = User.new(name: "Example user", email: "example@email.com", password: "password", password_confirmation: "password")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:about) }
	it { should respond_to(:birthday) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:authenticate) }

	describe "when email is not present" do 
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do 
		it "should be invalid" do 
			invalid_emails = %w(email@email email email@some+where.com email.com)
			invalid_emails.each do |e| 
				@user.email = e
				expect(@user).not_to be_valid			
			end	
		end
	end

	describe "when email format is valid" do 
		it "shoudl be valid" do 
			valid_emails = %w(email@email.com em_aIL@email.com em.a.i.l@email.com email@e.m.ail.com)
			valid_emails.each do |e|
				@user.email = e
				expect(@user).to be_valid
			end
		end
	end

	describe "when email address is already taken" do 
		before do 
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "when password is not present" do 
		before do 
			@user = User.new(name: "example", email: "example@email.com", password: " ", password_confirmation: " ")
		end

		it { should_not be_valid }
	end

	describe "when passwords do not match" do 
		before do 
			@user.password_confirmation = "mismatch"
		end

		it { should_not be_valid }
	end

	describe "return value of authenticate method" do 
		before do 
			@user.save
			let(:found_user) { User.find_by(email: @user.email) }
		end

		describe "when password is valid" do 
			it { should_be found_user.authenticate(@user.password) }
			# expect(:found_user.authenticate("password")).to_eq :found_User
		end

		describe "when password is invalid" do 
		end
 	end

end