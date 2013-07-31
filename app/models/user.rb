class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pledges
  has_many :comments
  has_many :events
  has_many :funded_projects, :through => :pledges, :source => :project
  has_many :projects
end
