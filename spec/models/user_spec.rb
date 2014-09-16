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
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

end