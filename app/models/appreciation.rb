class Appreciation < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  belongs_to :question
  belongs_to :article
  belongs_to :testimony
  belongs_to :prayer_request
end
