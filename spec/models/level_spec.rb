require 'rails_helper'

describe "Level" do 
	before do 
		@level = Level.new(name: "pre-alpha", organization: "ISI")
	end

	subject { @level }

	it { should respond_to(:name) }
	it { should respond_to(:organization) }
	it { should respond_to(:skills) }
end