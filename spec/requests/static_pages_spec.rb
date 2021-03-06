require 'rails_helper'

# RSpec.describe "StaticPages", :type => :request do
#   describe "GET /static_pages" do
#     it "works! (now write some real specs)" do
#       get static_pages_index_path
#       expect(response).to have_http_status(200)
#     end
#   end
# end

describe "StaticPages" do 

	describe "Home page" do 
		it "should have the content 'Home Page'" do 
			visit '/'
			expect(page).to have_content('Home Page')
		end

		it "should have title 'EdgeTracer'" do 
			visit '/'
			expect(page).to have_title('EdgeTracer')
		end
	end

end