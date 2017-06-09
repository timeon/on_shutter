class Answer < ActiveRecord::Base
  
  @@posts_name  = "questions"
  @@is_response = false

  include Content

  cattr_reader  :is_response
  cattr_reader  :posts_name
  
  belongs_to :user
  belongs_to :question

  validates_numericality_of :user_id
  validates_numericality_of :question_id
  validates_presence_of     :body
  
  acts_as_voteable
  acts_as_commentable

  def title
    question.title
  end
  
  def post_id
    question.id
  end
end
