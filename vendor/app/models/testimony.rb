class Testimony < ActiveRecord::Base
  include Content

  cattr_reader  :per_page

  belongs_to    :user
  has_many      :echos, :dependent => :destroy
  has_many      :appreciations
  has_many      :favers, :through => :appreciations, :source => :user

  validates_presence_of :title
  validates_presence_of :body

  acts_as_voteable
  acts_as_commentable
end
