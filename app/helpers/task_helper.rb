# frozen_string_literal: true

module TaskHelper
	def split_tag(tag)
		delimiters = [' ', ',', "，", "、", ";", "；"]
    tag.split(Regexp.union(delimiters))
	end
end
