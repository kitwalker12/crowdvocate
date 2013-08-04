class Project < ActiveRecord::Base
  belongs_to :user
  has_many :pledges
  has_many :events
  has_many :videos
  has_many :users, :through => :pledges

  has_attached_file :image, :styles => { :main => "300x300>", :thumb => "100x100>" }, :default_url => "http://placehold.it/300x300&text=No+Photo"

  scope :published, -> { where(published: true).where("published_at < ?", Time.zone.now).order('published_at DESC') }
end
