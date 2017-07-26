class Expense < ActiveRecord::Base
  belongs_to :profile
  belongs_to :item
  
  validates :exp_date, :presence => true
  validates :amt, :presence => true
  validates :item_id, :presence => true
  
  def month
    self.exp_date.strftime("%b '%y")
  end
  
  def day
    self.exp_date.strftime("%d %b")
  end
  
  def category
    Category.find(Item.find(item_id).category_id).name
  end
end
