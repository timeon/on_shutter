class Album < ActiveRecord::Base
  include Content
  cattr_reader  :per_page

  has_many :photos
  belongs_to :cover_photo, :class_name => "Photo", :foreign_key => "cover_photo_id"
  belongs_to :user
  
  def cover_image_url
    if cover_photo == nil
      if photos.length > 0
        cover_photo = photos[0]
        self.save
        photos[0].image.url(:tiny)
      else
        "/images/album_cover.png"
      end
    end
  end
  
  #def image
  #  cover_photo.image
  #end  
end
