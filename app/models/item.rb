class Item < ActiveRecord::Base
  belongs_to :category
  
  has_many :expenses, :dependent => :destroy
  
    validates :name, :presence => true
    before_save :title_fields
    validates_uniqueness_of :name, :scope => :category_id, :case_sensitive => false

    def title_fields
      self.name = self.name.titleize
    end
    
    def itm_with_cat
      "#{Category.find(category_id).name} - #{name}"
    end
end
