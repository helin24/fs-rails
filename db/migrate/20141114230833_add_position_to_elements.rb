class AddPositionToElements < ActiveRecord::Migration
  def change
  	add_column :elements, :top, :float
  	add_column :elements, :left, :float
  end
end
