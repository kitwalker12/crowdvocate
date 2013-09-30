class Project < ActiveRecord::Base
  belongs_to :user
  has_many :pledges
  has_many :events
  has_many :videos
  has_many :pledged_users, :through => :pledges, :source => :user

  after_initialize :init

  has_attached_file :image, :styles => { :main => "300x300>", :thumb => "100x100>" }, :default_url => "http://placehold.it/300x300&text=No+Photo"

  validates :slug, uniqueness: true, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :body, presence: true
  validates :goal, numericality: { only_integer: true, greater_than: 0 }
  validate :deadline_cannot_be_in_the_past

  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline < Time.now
      errors.add(:deadline, "can't be in the past")
    end
  end

  before_validation :generate_slug

  scope :published, -> { where(published: true).where("published_at < ?", Time.zone.now).order('published_at DESC') }

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  def init
    self.published = false if (self.has_attribute? :published) && self.published.nil?
  end

  def raised
    self.pledges.to_a.sum(&:amount)
  end

end
