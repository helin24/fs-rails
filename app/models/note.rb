class Note < ActiveRecord::Base
	belongs_to :notable, polymorphic: true
	belongs_to :user
	belongs_to :author, class_name: "User", foreign_key: "author_id"
end
