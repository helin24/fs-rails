class UsersSkill < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  belongs_to :users_level
end
