class Element < ActiveRecord::Base
	belongs_to :routine
	belongs_to :elementable, polymorphic: true
end
