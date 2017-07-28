class Gcategory < ActiveRecord::Base
  belongs_to :group
  has_many :gitems, :dependent => :destroy
  
  validates :name, :presence => true
  before_save :title_fields
  validates_uniqueness_of :name, :scope => :group_id, :case_sensitive => false

  def title_fields
    self.name = self.name.titleize
  end
end
