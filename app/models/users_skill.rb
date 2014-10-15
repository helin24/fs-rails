class UsersSkill < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  belongs_to :users_level
  has_many :notes, as: :notable

  def self.max_progress
  	10
  end
end
