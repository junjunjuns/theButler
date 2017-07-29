class Group < ActiveRecord::Base
  # Many-To-Many rel with profiles(users) through memberships
  # A profile(user) can belong to many groups
  has_many :memberships, :dependent => :destroy
  has_many :profiles, :through => :memberships, :dependent => :destroy
  
  validates :name,
  :presence => true
  
  has_many :messages, :dependent => :destroy
  
  has_many :activities, :dependent => :destroy
  
  has_many :gexpenses, :dependent => :destroy
  
  has_many :gcategories, :dependent => :destroy
  
  def self.search(search)
    where("lower(name) LIKE ? OR lower(description) LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%")
  end
end
