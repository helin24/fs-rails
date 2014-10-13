require 'rails_helper'

describe "Skill" do 
	before do 
		@skill = Skill.new(name: "two foot glide")
	end

	subject { @skill }

	it { should respond_to(:name) }
	it { should respond_to(:level) }
	it { should respond_to(:users) }
end