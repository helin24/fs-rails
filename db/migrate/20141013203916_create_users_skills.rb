class CreateUsersSkills < ActiveRecord::Migration
  def change
    create_table :users_skills do |t|
      t.references :user, index: true
      t.references :skill, index: true
      t.integer :progress, default: 0

      t.timestamps
    end
  end
end
