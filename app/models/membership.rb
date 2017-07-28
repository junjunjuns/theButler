class Membership < ActiveRecord::Base
  belongs_to :profile
  belongs_to :group
  
  has_many :messages, :dependent => :destroy
  
  has_many :schedules, :dependent => :destroy
  
  has_many :gexpenses, :through => :member_expenses, :dependent => :destroy
end
