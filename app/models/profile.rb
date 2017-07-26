class Profile < ActiveRecord::Base
  belongs_to :user
  
  # Many-To-Many rel with groups through memberships
  # A profile(user) can belong to many groups
  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships, :dependent => :destroy
  
  has_many :categories, :dependent => :destroy
  has_many :expenses, :dependent => :destroy
  
  # Validates each field that must be filled in
  validates :fname,
  :presence => true
  
  validates :lname,
  :presence => true

    # For avatar settings
    # @references http://robmclarty.com/blog/how-to-install-image-magick-and-setup-paperclip
    has_attached_file :avatar, 
    # Where to save the image
    :path => ":rails_root/app/assets/images/:attachment/:id/:basename_:style.:extension",
    # URL to access the image on the web app
    :url => "/assets/:attachment/:id/:basename_:style.:extension",
    # Different sizes and quality
    :styles => {
      :thumb    => ['50x50#',  :jpg, :quality => 70],
      :preview  => ['250x250#',  :jpg, :quality => 70],
      :large    => ['600>',      :jpg, :quality => 70],
      :retina   => ['1200>',     :jpg, :quality => 30]
    },
    :convert_options => {
      :thumb    => '-set colorspace sRGB -strip',
      :preview  => '-set colorspace sRGB -strip',
      :large    => '-set colorspace sRGB -strip',
      :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
    }
    
    # Validates the image
    validates_attachment :avatar,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

end
