require 'uri'

class Note < ActiveRecord::Base
	belongs_to :notable, polymorphic: true
	belongs_to :user
	belongs_to :author, class_name: "User", foreign_key: "author_id"

	def nice_source
		links = URI.extract(self.source)
		text_with_links = "(#{self.source.dup})"
		links.each do |link|
			text_with_links.gsub!(link, "<a href='#{link}' target='_blank'>#{link}</a>")
		end
		text_with_links.gsub!(/<script(.)*\/script>/, "")
		return "" if text_with_links == "()"
		text_with_links
	end
end
