class Event < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :comments

  validates :body, presence: true
end
