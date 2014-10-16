require 'rails_helper'

describe 'UsersLevel' do 
	before do
		@users_level = UsersLevel.new()
		@users_skill1 = UsersSkill.create(progress: 5)
		@users_skill2 = UsersSkill.create(progress: 2)
	end

	subject { @users_level }

	it { should respond_to(:learned_points) }
	it { should respond_to(:total_points) }
	it { should respond_to(:level) }
	it { should respond_to(:user) }
	it { should respond_to(:users_skills) }

	describe "#users_skills" do
		it "should allow users_skills to be added" do 
			expect{ @users_level.users_skills << @users_skill1 }.to change{ @users_level.users_skills.length }.by(1)
		end
	end

	describe "#compute" do
		before do 
			@users_level.users_skills << [@users_skill1, @users_skill2]
			@users_level.save
		end

		it "should add together progress points of users_skills" do 
			expect{ @users_level.compute }.to change{ @users_level.learned_points }.by(7)
		end

		it "should add together total points of users_skills" do 
			expect{ @users_level.compute }.to change{ @users_level.total_points }.by(20)
		end
	end
end
