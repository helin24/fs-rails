class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
    	t.references :routine, index: true
    	t.references :elementable, polymorphic: true
    	t.time :time
    	t.integer :repetitions

      t.timestamps
    end
  end
end
