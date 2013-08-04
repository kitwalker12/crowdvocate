class Project < ActiveRecord::Base
  belongs_to :user
  has_many :pledges
  has_many :events
  has_many :videos
  has_many :users, :through => :pledges
end
