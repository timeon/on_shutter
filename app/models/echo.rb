class Echo < ActiveRecord::Base
  
  @@posts_name  = "testimonies"
  @@is_response = false

  include Content

  cattr_reader  :is_response
  cattr_reader  :posts_name
  
  belongs_to :user
  belongs_to :testimony

  validates_numericality_of :user_id
  validates_numericality_of :testimony_id
  validates_presence_of     :body
  
  acts_as_voteable
  acts_as_commentable

  def title
    testimony.title
  end
  
  def post_id
    testimony.id
  end
end
