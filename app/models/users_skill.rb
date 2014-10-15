class UsersSkill < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  belongs_to :users_level

  def self.max_progress
  	10
  end
end
