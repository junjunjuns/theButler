class Gexpense < ActiveRecord::Base
  belongs_to :profile
  belongs_to :group
  belongs_to :gitem
  has_many :member_expenses, :dependent => :destroy
  has_many :memberships, :through => :member_expenses, :dependent => :destroy
  
  validates :paid_on, :presence => true
  validates :total_amt, :presence => true

  
  def month
    self.paid_on.strftime("%b '%y")
  end
  
  def category
    Gcategory.find(Gitem.find(gitem_id).gcategory_id).name
  end
end
