class ChangePublicColumnInNotesToInteger < ActiveRecord::Migration
  def change
  	change_column :notes, :public, :integer
  end
end
