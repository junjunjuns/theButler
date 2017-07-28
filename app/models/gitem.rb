class Gitem < ActiveRecord::Base
  belongs_to :gcategory
  has_many :gexpenses, :dependent => :destroy
  
  validates :name, :presence => true
  before_save :title_fields
  validates_uniqueness_of :name, :scope => :gcategory_id, :case_sensitive => false

  def title_fields
    self.name = self.name.titleize
  end
    
  def itm_with_cat
    "#{Gcategory.find(gcategory_id).name} - #{name}"
  end
end
