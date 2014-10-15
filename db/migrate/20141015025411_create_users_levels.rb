class CreateUsersLevels < ActiveRecord::Migration
  def change
    create_table :users_levels do |t|
      t.references :user, index: true
      t.references :level, index: true
      t.integer :learned_points, default: 0
      t.integer :total_points, default: 0

      t.timestamps
    end
  end
end
