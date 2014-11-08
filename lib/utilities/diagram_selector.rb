require 'RMagick'
include Magick

class DiagramSelector
	attr_reader :pic

	def initialize(file)
		# could pass it a specific pdf page
		# or the entire pdf document and relevant pages
		# or a list of files
		@pic = ImageList.new(file)[0]
	end

	def all_colors
		colors = {}
		@pic.each_pixel do |pixel, c, r|
			color = pixel.to_color
			if colors[color] == nil
				colors[color] = 1
			else
				colors[color] += 1
			end
		end
		colors
		# look through every pixel
		# create hash that will include color=> frequency
		# for each pixel get color
		# add to hash
		# return hash
	end

	def crop_by_color(color, padding = 8)
		limits = color_range(color)
		x = limits["left"] - padding
		y = limits["top"] - padding
		width = limits["right"] - x + padding
		height = limits["bottom"] - y + padding
		@pic.excerpt(x, y, width, height)
	end

	def color_range(color, grid_size = 100)
		# find location of color start on column
		# find location of color start on row
		row = grid_size
		col = grid_size

		row_appearances = color_appearance_rows(color, grid_size)
		col_appearances = color_appearance_cols(color, grid_size)

		left = find_first(row_appearances, grid_size)
		right = @pic.columns - find_first(row_appearances.map{|pixels| pixels.reverse}, grid_size)
		top = find_first(col_appearances, grid_size)
		bottom = @pic.rows - find_first(col_appearances.map{|pixels| pixels.reverse}, grid_size)
		puts "found left #{left} right #{right} top #{top} bottom #{bottom}"
		limits = {"left" => left, "right" => right, "top" => top, "bottom" => bottom}
	end

	def find_first(appearances, grid_size)
		firsts = []
		appearances.each do |pixels|
			firsts << pixels.find_index(true)
		end

		firsts.delete_if{|num| num == nil }

		first = firsts.min
	end

	def color_appearance_rows(color, grid_size)
		row_appearances = []
		row = grid_size
		until row > @pic.rows do
			this_row = []
			row_pixels = @pic.get_pixels(0, row, @pic.columns, 1)
			row_pixels.each do |pixel|
				this_row << (pixel.to_color == color)
			end
			row_appearances << this_row
			row += grid_size
		end
		row_appearances
	end

	def color_appearance_cols(color, grid_size)
		col_appearances = []
		col = grid_size
		until col > @pic.columns do
			this_col = []
			col_pixels = @pic.get_pixels(col, 0, 1, @pic.rows)
			col_pixels.each do |pixel|
				this_col << (pixel.to_color == color)
			end
			col_appearances << this_col
			col += grid_size
		end
		col_appearances
	end

end