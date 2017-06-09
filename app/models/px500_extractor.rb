module Px500Extractor
  include PhotoExtractor
  @@added_photos = 0
  @@processed_photos = 0
  
  @@cats =
  [
    "",
    "Celebrity Photography, People Photography",
    "Film Photography",
    "Journalism Photography",
    "",
    "Black And White Photography",
    "Still Life Photography",
    "People Photography",
    "Landscape Photography",
    "City And Architecture Photography, Urban Photography",
    "Abstract Photography",
    "Animal Photography",
    "Macro Photography",
    "Travel Photography",
    "Fashion Photography",
    "Commercial Photography",
    "Concert Photography",
    "Sport Photography, Action Photography",
    "Nature Photography",
    "Performing Arts Photography, Art Photography",
    "Family Photography, People Photography",
    "Street Photography, Urban Photography",
    "Underwater Photography",
    "Food Photography",
    "Fine Art Photography, Art Photography",
    "Wedding Photography, People Photography",
    "Transportation Photography",
    "Urban Exploration Photography, Urban Photography",
  ]
    
  def process_500px(params)
    @@added_photos = 0
    @@processed_photos = 0
    page = 1
    type = "popular"
    
    parts  = params.split(" ")
    page   = parts[1].to_i if parts.size > 1
    offset = parts[2].to_i if parts.size > 2
    type   = parts[3] if parts.size > 3
    
    process_500px_type(page, offset, type)
  end  
  
  def process_500px_type(page, offset, type)
    http = HTTPClient.new
    page_url = "http://500px.com/#{type}"
    html = http.get_content(page_url)
    doc = Nokogiri::HTML(html)
    token = doc.xpath('//meta[@name="csrf-token"]/@content').map(&:value)[0]

    begin
      json_url = "https://api.500px.com/v1/photos?rpp=100&feature=#{type}&&image_size=5&page=#{page}&include_tags=true&authenticity_token=#{CGI.escape(token)}"
      json_str = http.get_content(json_url)
      json_data = JSON.parse(json_str)
      
      total_pages = json_data["total_pages"]
      
      json_data["photos"].each do |data|
        @@processed_photos = @@processed_photos + 1
        logger.info "#{@@added_photos}/#{@@processed_photos} page=#{page} #{data["url"]}"
         
        if data["category"] != 4 and @@processed_photos >= offset
          add_500px_photo data
        end
      end    
  
      sleep(Random.rand(100)*3.0/100)
      
      page =  page + 1

    end while  !@e and page <= total_pages
  end

  def add_500px_photo(data)
    image_url   = data["image_url"]
    image_id    = "500px-#{data["id"]}" 
    cat_id      = data["category"]
    cat_id      = 0 if cat_id == nil or cat_id > 27 
    categories  = @@cats[cat_id]
    
    author_name = data["user"]["fullname"]
    author_name = "Unknown" if author_name.blank? 
    user = add_user author_name
    
    tags_array  = data["tags"]
    
    desc          = data["description"]
    desc          = desc.gsub("\n", "<br>") if desc    
    
    photo = Photo.find_by(image_remote_id: image_id)
    if photo   
      existing = true   
      logger.info "updating photo #{photo.id} user=#{user} cat=#{categories} rating=#{data['positive_votes_count']} views=#{data["times_viewed"]} #{image_url} "
    else
      existing = false
      logger.info "adding photo user=#{user} cat=#{categories} rating=#{data['positive_votes_count']} views=#{data["times_viewed"]} #{image_url}"
      photo = Photo.new 
      photo.image_remote_id   = image_id
      photo.image_remote_url  = image_url
      photo.image_url         = image_url  
    end
    
    photo.user              = user 
    photo.title             = data["name"]
    photo.body              = desc
    photo.image_referer_url = "https://500px.com" + data["url"]  
    photo.rating            = data['positive_votes_count']
    photo.base_view_count   = data["times_viewed"]
    photo.taken_at          = data["taken_at"]
    photo.tag_list          = remove_accent tags_array.join(", ")
    photo.category_list.add(categories, parse: true)
debugger
    photo.save

    @@added_photos = @@added_photos + 1
  end
     
end

