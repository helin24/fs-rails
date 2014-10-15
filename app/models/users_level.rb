class UsersLevel < ActiveRecord::Base
  belongs_to :user
  belongs_to :level
  has_many :users_skills
end
