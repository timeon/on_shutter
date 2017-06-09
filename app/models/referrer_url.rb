class ReferrerUrl < ActiveRecord::Base
  has_many :users;
  has_many :hits;  
end
