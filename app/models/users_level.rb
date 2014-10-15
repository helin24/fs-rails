class UsersLevel < ActiveRecord::Base
  belongs_to :user
  belongs_to :level
  has_many :users_skills

  def compute
  	self.learned_points = self.users_skills.sum(:progress)
  	self.total_points = self.users_skills.count * UsersSkill.max_progress
  	self.save
  end
end
