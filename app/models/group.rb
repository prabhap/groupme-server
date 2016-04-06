class Group < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  has_many :conversations
  has_many :user_groups
  has_many :users, through: :user_groups

end
