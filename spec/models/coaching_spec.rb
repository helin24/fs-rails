require 'rails_helper'

describe 'Coaching' do 
	before do
		@skater = User.new(name: "skater", email: "newskater@email.com", password: "password")
		@coach = User.new(name: "coach", email: "coach@email.com", password: "password")
	end

	describe "when no relationships exist" do
		it "should have no skaters for coach" do 
			expect(@coach.skaters).to eq([])
		end

		it "should have no coaches for skater" do 
			expect(@skater.coaches).to eq([])
		end
	end

	describe "when skater is assigned a coach" do 
		it "should change number of coaches a skater has" do 
			puts "coaches now is #{@skater.coaches.inspect}"
			expect { @skater.coaches << @coach; @skater.save }.to change { @skater.coaches.count }.by(1)
			expect(@skater.coaches[0]).to eq(@coach)
		end

		it "should assign skater to coach" do 
			expect { @coach.skaters << @skater; @coach.save }.to change { @coach.skaters.count }.by(1)
			expect(@coach.skaters[0]).to eq(@skater)
		end
	end
end