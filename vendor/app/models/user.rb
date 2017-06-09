# https://github.com/chrislloyd/gravtastic
# https://github.com/brady8/fav_star
# https://github.com/brady8/acts-as-taggable-on
# http://ruby.railstutorial.org/chapters/following-users#sec%3athe_relationship_model

require 'aasm_roles'
class User < ActiveRecord::Base
  include AasmRoles

  include Gravtastic
  gravtastic :rating => 'PG'

  #devise :omniauthable
  
  acts_as_voter
  has_karma(:photos,    :as => :user, :weight => 1)
  has_karma(:critiques, :as => :user, :weight => 1)

  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable
  validates_uniqueness_of :login, :email, :case_sensitive => false

  before_validation { |u| u.login.downcase! }
  
  validates :login, :exclusion => {:in => %w(root, administrator, superuser, system, support, login, free, admin, dev, test, user, users),
                    :message  => "is reserved" }

  # Relations
  has_and_belongs_to_many :roles

  # omni auth services
  has_many :services
#  attr_accessible :name, :email

  has_many :fanships
  has_many :favorite_users, :through => :fanships, :source => :favorite_user
  has_many :fans, :through => :fanships, :foreign_key =>:favorite_user, :primary_key =>:favorite_user, :source => :user

  has_many :appreciations
  has_many :favorite_photos,          :through => :appreciations, :source => :photo
  has_many :favorite_questions,       :through => :appreciations, :source => :question
  has_many :favorite_articles,        :through => :appreciations, :source => :article
  has_many :favorite_testimonies,     :through => :appreciations, :source => :testimony
  has_many :favorite_prayer_requests, :through => :appreciations, :source => :prayer_request
   
  has_one  :profile,        :dependent => :destroy
  has_many :contacts,       :dependent => :destroy
  
  has_one  :profile_photo,  :class_name=> "Photo"

  has_many :collections,    :dependent => :destroy
  has_many :albums,         :dependent => :destroy

  has_many :photos,         :dependent => :destroy
  has_many :critiques,      :dependent => :destroy

  has_many :questions,      :dependent => :destroy
  has_many :answers,        :dependent => :destroy

  has_many :articles,       :dependent => :destroy
  has_many :reviews,        :dependent => :destroy
  
  has_many :testimonies,    :dependent => :destroy
  has_many :echos,          :dependent => :destroy

  has_many :prayer_requests,:dependent => :destroy
  has_many :prayers,        :dependent => :destroy
  
  # Hooks
  after_create :create_profile, :register!
  
  before_validation(:set_default, :on => :create)
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password. 
      User.create(:email => data["email"], :password => Devise.friendly_token[0,20]) 
    end
  end  
  
  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end  
  
  def self.search(search)  
    if search  
       find(:all, :conditions => ['login LIKE ? OR email LIKE ?', "%#{search}%", "%#{search}%"])
    else  
      all
    end
  end
  
  def seen
    if self[:seen]
      self[:seen]
    else
      self[:created_at]
    end
  end

  def display_name
    if self.name and self.name.length > 0
      self.name
    else self.login
      self.login
    end
  end

  def to_s
    "#{id} #{display_name}"  
  end
  
  
  def website
    if self[:website] == nil
      ""
    elsif self[:website].index("http://") || self[:website].index("https://")
      self[:website]
    else
      "http://" + self[:website]
    end
  end

  def admin?
    has_role?(:admin)
  end

  def moderator?
    has_role?(:moderator)
  end
  
  def coworker?
    has_role?(:coworker)
  end
  
  def has_role?(role)
    role_symbols.include?(role.to_sym) || role_symbols.include?(:admin)
  end
  
  def role_symbols
    @role_symbols ||= roles.map {|r| r.name.underscore.to_sym }
  end

  def openid_login?
    !identity_url.blank? #|| (AppConfig.enable_facebook_auth && !facebook_id.blank?)
  end

  def twitter_login?
    !twitter_token.blank? && !twitter_secret.blank?
  end
  
  def not_using_openid?
    !openid_login?
  end
  
  def normalize_identity_url
    self.identity_url = OpenIdAuthentication.normalize_url(identity_url) if openid_login?
  rescue
    errors.add_to_base("Invalid OpenID URL")
  end
  
  def self.find_for_database_authentication(conditions={})
    self.where("login = ?", conditions[:login]).limit(1).first ||
    self.where("email = ?", conditions[:login]).limit(1).first
  end

  def collect_photos_to_album
    if albums.length == 0
      album = albums.build(:title => "#{name}'s best")
      album.save
    end
    
    album = albums[0]
    photos.each do |photo|
      if !photo.album
        photo.album = album
        photo.save
      end
    end
  end
  
  def post_count
    photos.count + articles.count + questions.count + testimonies.count + prayer_requests.count
  end
  
  def response_count
    critiques.count + reviews.count + answers.count + echos.count + prayers.count
  end
  
  def title
    name or email.split("@")[0]
  end
  
  def place_holder?
    email.include? "@user.onshutters.com"
  end
  
  protected

  def password_required?
    return false if openid_login?
    return false if twitter_login?
    (encrypted_password.blank? || !password.blank?)
  end

  
  def create_profile
    # Give the user a profile
    self.profile = Profile.create    
  end
 
  private
  
  def set_default

  end
  
end
