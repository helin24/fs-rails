class CreateFieldMoves < ActiveRecord::Migration
  def change
    create_table :field_moves do |t|
    	t.string :name
    	t.string :image
    	t.references :test_level, index: true

      t.timestamps
    end
  end
end
