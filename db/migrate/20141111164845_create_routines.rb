class CreateRoutines < ActiveRecord::Migration
  def change
    create_table :routines do |t|
      t.string :name
      t.text :description
      t.references :user, index: true
      t.references :author, index: true
      t.integer :length

      t.timestamps
    end
  end
end
