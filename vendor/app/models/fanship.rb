class Fanship < ActiveRecord::Base
  belongs_to :user
  belongs_to :favorite_user, :class_name => "User", :foreign_key => "favorite_user_id"
end
