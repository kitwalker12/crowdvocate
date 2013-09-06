class Project < ActiveRecord::Base
  belongs_to :user
  has_many :pledges
  has_many :events
  has_many :videos
  has_many :users, :through => :pledges

  has_attached_file :image, :styles => { :main => "300x300>", :thumb => "100x100>" }, :default_url => "http://placehold.it/300x300&text=No+Photo"

  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug

  scope :published, -> { where(published: true).where("published_at < ?", Time.zone.now).order('published_at DESC') }

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

end
