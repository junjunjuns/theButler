class Group < ActiveRecord::Base
  # Many-To-Many rel with profiles(users) through memberships
  # A profile(user) can belong to many groups
  has_many :memberships
  has_many :groups, :through => :memberships
  
  def self.search(search)
    where("name LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
  end
end
