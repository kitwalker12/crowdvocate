class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :votes

  validates :url, presence: true
end
