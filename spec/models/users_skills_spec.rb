require 'rails_helper'

describe 'UsersSkill' do
	before do
		@users_skill = UsersSkill.new()
	end

	subject { @users_skill }

	it { should respond_to(:user) }
	it { should respond_to(:skill) }
	it { should respond_to(:users_level) }
	it { should respond_to(:progress) }
end