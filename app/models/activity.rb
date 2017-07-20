class Activity < ActiveRecord::Base
  belongs_to :group
  
  has_many :schedules, :dependent => :destroy
  
  validates :name,
  :presence => true
end
