class AddCustomNameToElements < ActiveRecord::Migration
  def change
  	add_column :elements, :custom_name, :text
  end
end
