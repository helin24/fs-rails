class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :text
      t.string :source
      t.integer :public
      t.references :notable, polymorphic: true
      t.references :user, index: true
      t.references :author, index: true

      t.timestamps
    end
  end
end
