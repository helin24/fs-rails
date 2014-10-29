class AddUserRefToNotes < ActiveRecord::Migration
  def change
    add_reference :notes, :user, index: true
    add_reference :notes, :author, index: true
  end
end
