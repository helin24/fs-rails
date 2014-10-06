class AddColumnStartedSkatingToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :started_skating, :date
  end
end
