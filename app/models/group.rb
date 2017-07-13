class Group < ActiveRecord::Base
  # Many-To-Many rel with profiles(users) through memberships
  # A profile(user) can belong to many groups
  
  has_many :memberships
  has_many :groups, :through => :memberships
end
