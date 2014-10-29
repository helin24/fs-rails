class CreateTestLevels < ActiveRecord::Migration
  def change
    create_table :test_levels do |t|
    	t.string :name
    	t.string :standard_code

      t.timestamps
    end
  end
end
