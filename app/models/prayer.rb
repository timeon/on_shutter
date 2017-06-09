class Prayer < ActiveRecord::Base
  
  @@posts_name  = "prayer_requests"
  @@is_response = false

  include Content

  cattr_reader  :is_response
  cattr_reader  :posts_name
  
  belongs_to :user
  belongs_to :prayer_request

  validates_numericality_of :user_id
  validates_numericality_of :prayer_request_id
  validates_presence_of     :body
  
  acts_as_voteable
  acts_as_commentable

  def title
    prayer_request.title
  end
  
  def post_id
    prayer_request.id
  end
end
