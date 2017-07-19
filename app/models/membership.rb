class Membership < ActiveRecord::Base
  belongs_to :profile
  belongs_to :group
  
  has_many :message
end
