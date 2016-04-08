class User < ActiveRecord::Base
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_one_time_password
end
