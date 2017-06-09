class Critique < ActiveRecord::Base
  
  @@posts_name  = "photos"
  @@is_response = false

  include Content

  cattr_reader  :is_response
  cattr_reader  :posts_name
  
  belongs_to :user
  belongs_to :photo

  validates_numericality_of :user_id
  validates_numericality_of :photo_id
  validates_presence_of     :body
  
  acts_as_voteable
  acts_as_commentable

  def title
    photo.title
  end
  
  def post_id
    photo.id
  end
  
  def image
    photo.image
  end
end
