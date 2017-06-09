module Content
  def anchor
    if respond_to?(:is_response)
      "/#{posts_name}/#{post_id.to_s}#response_#{id.to_s}"
    elsif resource_name == "album"
      "/photos?album=#{id.to_s}"
    else  
      show_path
    end  
  end

  def new_response_archor
    "/#{posts_name}/#{post_id}/#new_response"  
  end
  
  @@per_page = 10  
  
  def resource_name
    if @resource != nil
      @resource
    else  
      @resource = self.class.name.underscore
    end  
  end    
      
  def self.index_path(resource_name)
    "/#{resource_name.pluralize}"
  end 

  def self.page_path(resource_name, page)
    "/#{resource_name.pluralize}?page=#{page}"
  end 

  def show_path
    "/#{resource_name.pluralize}/#{id}"
  end 

  def edit_path
     "/#{resource_name.pluralize}/#{id}/edit"
  end
  
  def star_path
     "/#{resource_name.pluralize}/#{id}/star"
  end
  
  def comment_path
     "/#{resource_name.pluralize}/#{id}/comment"
  end
  
  def vote_up_path
     "/#{resource_name.pluralize}/#{id}/vote_up"
  end

  def vote_down_path
     "/#{resource_name.pluralize}/#{id}/vote_down"
  end
    
end
