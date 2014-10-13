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
	it { should respond_to(:started_skating) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:skills) }

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

	describe "when password is too short" do 
		before { @user.update(password: "123", password_confirmation: "123") }
		it { should be_invalid }
	end

	describe "return value of authenticate method" do 
		before do 
			@user.save
		end
		let(:found_user) { User.find_by(email: @user.email) }

		describe "when password is valid" do 
			it { should eq found_user.authenticate(@user.password) }
		end

		describe "when password is invalid" do 
			let(:wrong_attempt) { found_user.authenticate("wrong password") } # just defining wrong_attempt = found_user doesn't work. In that case, found user is not found.
			it { should_not eq wrong_attempt }
			specify { expect(wrong_attempt).to eq false }
		end
 	end

 	describe "remember token" do 
 		before { @user.save }
 		it { expect(@user.remember_token).not_to be_blank }
 	end

end