class CreateUsersTestLevels < ActiveRecord::Migration
  def change
    create_table :users_test_levels do |t|
    	t.references :user, index: true
    	t.references :test_level, index: true
    	t.date :achieved_on
      t.timestamps
    end
  end
end
