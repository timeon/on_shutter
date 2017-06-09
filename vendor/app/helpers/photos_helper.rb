module PhotosHelper
  def index_path(query_hash)
    send("photos_path", query_hash)
  end    
end
