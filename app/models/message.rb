class Message < ActiveRecord::Base
  belongs_to :group
  belongs_to :profile
  
  validates :content,
  :presence => true
end
