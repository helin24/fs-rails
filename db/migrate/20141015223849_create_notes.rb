class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :text
      t.string :source
      t.string :public
      t.references :notable, polymorphic: true

      t.timestamps
    end
  end
end
