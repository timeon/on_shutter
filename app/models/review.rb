class Review < ActiveRecord::Base
  
  @@posts_name  = "articles"
  @@is_response = false

  include Content

  cattr_reader  :is_response
  cattr_reader  :posts_name
  
  belongs_to :user
  belongs_to :article

  validates_numericality_of :user_id
  validates_numericality_of :article_id
  validates_presence_of     :body
  
  acts_as_voteable
  acts_as_commentable

  def title
    article.title
  end
  
  def post_id
    article.id
  end
end
