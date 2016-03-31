class Group < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  has_many :conversations

end
