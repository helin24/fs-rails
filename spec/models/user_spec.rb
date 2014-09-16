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



end