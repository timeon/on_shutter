class Doc < ActiveRecord::Base
  include Content
  belongs_to        :user
  has_attached_file :file
  
  def before_save
    if !self.name or self.name.length < 1
      self.name = self.file_file_name
    end
  end
  
end
