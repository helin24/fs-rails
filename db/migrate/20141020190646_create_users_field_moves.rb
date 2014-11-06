class CreateUsersFieldMoves < ActiveRecord::Migration
  def change
    create_table :users_field_moves do |t|
    	t.references :user, index: true
    	t.references :field_move, index: true
    	t.references :users_test_level, index: true
    	t.integer :progress, default: 0

      t.timestamps
    end
  end
end
