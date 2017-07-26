class Category < ActiveRecord::Base
    belongs_to :profile
    has_many :items, :dependent => :destroy
    
    validates :name, :presence => true
    before_save :title_fields
    validates_uniqueness_of :name, :scope => :profile_id, :case_sensitive => false

    def title_fields
        self.name = self.name.titleize
    end
end
