require 'rails_helper'

describe "User" do 
	before do 
		@user = User.new(name: "Example user", email: "example@email.com", password: "password", password_confirmation: "password")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
end