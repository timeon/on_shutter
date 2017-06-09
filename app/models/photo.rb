# http://trevorturk.com/2008/12/11/easy-upload-via-url-with-paperclip/
require 'exifr' 
require 'open-uri'

class Photo < ActiveRecord::Base
  include Content
  extend OneBigPhotoExtractor
  extend FlickrExtractor
  extend Px500Extractor
  
  extend FriendlyId
  friendly_id :title, use: :history
  
  cattr_reader  :per_page
  attr_accessor :image_url

  belongs_to        :user
  belongs_to        :album
  has_many          :critiques, :dependent => :destroy
  has_many          :appreciations
  has_many          :favers, :through => :appreciations, :source => :user
  has_attached_file :image, :styles => {:tiny=>"55x55#", :thumb=> "200x75>", :large => "960x3000>" },
                            :path   => ":rails_root/public/system/:attachment/:id/:style/:filename",
                            :url    => "/system/:attachment/:id/:style/:filename"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'
  before_validation  :download_remote_image, :if => :image_url_provided?, :on => :create

  acts_as_voteable
  acts_as_commentable
  
  acts_as_taggable_on :categories, :tags, :collections

  METERING_MODE =[      "Unknown",
                        "Average",
                        "Center Weighted Average",
                        "Spot",
                        "MultiSpot",
                        "Pattern",
                        "Partial"]

  EXPOSURE_PROGRAM = [  "Unknown",
                        "Manual",
                        "Normal Program",
                        "Aperture Priority",
                        "Shutter Priority",
                        "Creative Program",
                        "Action Program",
                        "Portrait Mode",
                        "Landscape Mode"]

  after_image_post_process  :extract_exif_data 


  def next
    Photo.where("id > ?", id).order("id ASC").first
  end

  def prev
    Photo.where("id < ?", id).order("id DESC").first
  end
  
  def metering_mode_str
    if metering_mode and metering_mode < METERING_MODE.length
      METERING_MODE[metering_mode] + ' (' + metering_mode.to_s + ')'
    else
      "Unkonwn"
    end
  end

  def exposure_program_str
    if exposure_program and exposure_program < EXPOSURE_PROGRAM.length
      EXPOSURE_PROGRAM[exposure_program] + ' (' + exposure_program.to_s + ')'
    else
      "Unkonwn"
    end
  end

  def taken_at_str
    if taken_at
      taken_at.strftime("%b %d, %Y")
    else
      ""
    end
  end

  # Define Paperclip callback just for the Photo attachment 
  # before_post_process :nice_file_name

  def nice_file_name
    debugger
    if title
      self.image.instance_write(:file_name, self.title.strip.downcase.gsub( /[^a-z0-9]/, '-') + File.extname(self.image_file_name))
    end  
  end

  # Callback after styles processing (thumbnails). 
  # Use this to extract Exif metadata from image using RMagick 
  def extract_exif_data 
    file_path = image.queued_for_write[:original].path
    if File.exist?(file_path)
      begin
        exifr =EXIFR::JPEG.new(file_path) 
    
        self.height   = exifr.height
        self.width    = exifr.width
        self.make     = exifr.make.chomp(" CORPORATION") if exifr.make
        self.model    = exifr.model
  
        self.f_number       = exifr.f_number.to_f if !exifr.f_number.nan? 
        self.focal_length   = exifr.focal_length.to_s
        self.exposure_time  = exifr.exposure_time.to_s
  
        self.iso            = exifr.iso_speed_ratings
        self.flash          = exifr.flash
        self.white_balance  = exifr.white_balance
        self.exposure_program    = exifr.exposure_program
        self.exposure_bias_value = exifr.exposure_bias_value.to_s if exifr.exposure_bias_value
        self.metering_mode       = exifr.metering_mode
  
        self.taken_at     = exifr.date_time
        self.date_digitized = exifr.date_time_digitized
        self.date_original  = exifr.date_time_original
  
        # self.created_at     = DateTime.now - 7.days + rand(1440*7).minutes if self.taken_at != nil
      rescue
      end
    end
  end 

  def image_url_provided?
    !self.image_url.blank?
  end

  def download_remote_image
    if do_download_remote_image
      self.image = do_download_remote_image
      self.image_remote_url = image_url
      true
    else
      false
    end
  end

  def do_download_remote_image
    if image_referer_url
      io = open(URI.parse(image_url), 
                "Referer" => image_referer_url,
                "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36")
    else
      io = open(URI.parse(image_url), 
                "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36")
    end   
    def io.original_filename; base_uri.path.split('/').last.gsub("%", "_"); end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
    debugger
    nil
  end

  def fix_tags
    Photo.all.each do |photo|
      photo.tag_list = ""
      photo.save
      photo.tag_list = Photo.remove_accent(photo.tag_list.to_s)
      photo.save
    end
  end

end
