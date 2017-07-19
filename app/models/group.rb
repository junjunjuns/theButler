class Group < ActiveRecord::Base
  # Many-To-Many rel with profiles(users) through memberships
  # A profile(user) can belong to many groups
  has_many :memberships
  has_many :profiles, :through => :memberships
  
  validates :name,
  :presence => true
  
  has_many :messages
  
  def self.search(search)
    where("name LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
  end
end
