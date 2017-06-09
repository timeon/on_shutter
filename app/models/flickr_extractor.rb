module FlickrExtractor
  include PhotoExtractor
  @@added_photos = 0
  @@processed_photos = 0
  
  @@groups = [

    "https://www.flickr.com/photos/ania_nyc/10870848836/in/pool-900faves",
    "https://www.flickr.com/photos/izakigur/4756960631/in/pool-800faves",
    "https://www.flickr.com/photos/castello01/13542286835/in/pool-700faves",
    "https://www.flickr.com/photos/di_kiy/10202878705/in/pool-600faves",
    "https://www.flickr.com/photos/46059838@N04/12185789886/in/pool-500faves",
    "https://www.flickr.com/photos/46059838@N04/13896077066/in/pool-400faves",
    "https://www.flickr.com/photos/46059838@N04/12309321525/in/pool-300faves",
    "https://www.flickr.com/photos/46059838@N04/13892149207/in/pool-200faves/",
    "https://www.flickr.com/photos/12382460@N03/4139334987/in/pool-cotc",
    #"https://www.flickr.com/photos/48042895@N00/13919374800/in/pool-greatportrait",
    #"https://www.flickr.com/photos/akira2008/3884593393/in/pool-spectacular_landscapes/",
    #"https://www.flickr.com/photos/bontragger/13935969563/in/pool-landscape_exhibition/",
    #"https://www.flickr.com/photos/stephanna-g/12862101154/in/pool-best100only",
    #"https://www.flickr.com/photos/visbeek/11014059995/in/pool-sgtpeppers/",
    #"https://www.flickr.com/photos/thomashawk/14077248125/in/set-72157600097882463/"
    ]
    
  def process_flickr(url)
    @@added_photos = 0
    @@processed_photos = 0
    if    url == "update flickr groups"
      update_flickr_groups
    elsif url == "update flickr"
      update_flickr
    elsif url.include? "flickr.com"
      crawl_flickr url.split(" ")[0], url.split(" ").size > 1 ? url.split(" ")[1].to_i : 5  
    end
  end  

  def update_flickr_groups()
    @@groups.each do |group|
      crawl_flickr(group, 200000)
    end 
  end

  
  def crawl_flickr(url, pages)
    last_last_url = nil
    last_url = nil 
    
    i = 0
    begin
      last_last_url = last_url 
      last_url = url 
      
      if Rails.env.development?
          url = process_flickr_page(url)
      else      
        begin
          url = process_flickr_page(url)
        rescue => e
          puts e.backtrace
        end
      end
              
      if url == last_url and last_url == last_last_url
        break
      end
       
      sleep(Random.rand(100)*1.0/100)
      i = i + 1
    end while url and !@e and i < pages
    
  end
    
    
  def process_flickr_page(url)
    @@processed_photos = @@processed_photos + 1  
    logger.info "#{@@added_photos}/#{@@processed_photos} #{url}"
    html = open(url, "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36")  
    
    doc = Nokogiri::HTML(html)

    next_links = doc.css('#nav-bar-next')

    end_sequence = process_flickr_photo_page(doc, url)
    
    if next_links and next_links[0]  
      path = next_links[0]['href']
      if !path or path.include? "http"
        next_page_url = nil
      else  
        next_page_url = "https://www.flickr.com" +  next_links[0]['href']
      end  
    end   
    
    next_page_url
  end


  def process_flickr_photo_page(doc, url)

#  <a href="https://www.flickr.com/photos/patcharles/9863857893/"  title="Ships of the Cable Beach by Pat Charles, on Flickr">
#      <img src="https://farm8.staticflickr.com/7460/9863857893_c70385294f_h.jpg" width="1600" height="1063" alt="Ships of the Cable Beach">
#    </a>

=begin
    h_photo_info = doc.css('#share-options-embed-textarea-h')[0]
    h_photo_info = h_photo_info.children[0] if h_photo_info

    o_photo_info = doc.css('#share-options-embed-textarea-o')[0]
    o_photo_info = o_photo_info.children[0] if o_photo_info
    
    m_photo_info = doc.css('#share-options-embed-textarea-m')[0]
    m_photo_info = m_photo_info.children[0] if m_photo_info
    
    if h_photo_info
      photo_info = h_photo_info.to_s.gsub("&lt\;", "<").gsub("&gt\;", ">")
    elsif o_photo_info
      photo_info = o_photo_info.to_s.gsub("&lt\;", "<").gsub("&gt\;", ">")  
    elsif m_photo_info
      photo_info = m_photo_info.to_s.gsub("&lt\;", "<").gsub("&gt\;", ">")  
    end

    info_doc = Nokogiri::HTML(photo_info)

# to be done 
# https://www.flickr.com/photos/cedarsphoto/10185053775/in/pool-best100only/
        
    image_url     = info_doc.css('img')[0][:src]
    title         = info_doc.css('img')[0][:alt]
    author_name   = doc.css(".photo-name-line-1 a").text.strip
    rating        = doc.css("#button-bar-fave")[0].children[2].to_s.to_i
    view_count    = doc.css(".full-text")[0].text.strip[0..-7].gsub(",", "").to_i
    desc          = doc.xpath('//meta[@name="description"]/@content').map(&:value)[0].strip.capitalize
    desc          = doc.css('#description_div').text.strip.capitalize
    categories    = ""
=end
    
    doc_text = doc.text.to_s
    
    func_start_index = doc_text.index('Y.photo.init')
    return false    if !func_start_index
    func_end_index   = doc_text.index('Y.refreshPhotoPageDescription.init')
    func             = doc_text[func_start_index..func_end_index]
    
    json_start_index = func.index('({')
    json_end_index   = func.rindex('})')
    json_str = func[json_start_index+1..json_end_index]
    
    begin    
      data = JSON.parse(json_str)
    rescue
      return false
    end    

    author_name   = data["ownername"]
    taken_at      = data["date_taken"]
    title         = data["title"]
    image_id      = "flickr-" + data["id"]
    image_url     = data["sizes"]["h"]["url"] if data["sizes"]["h"] #1600
    image_url     = data["sizes"]["l"]["url"] if  !image_url and data["sizes"]["l"] #1024
    #image_url     = data["sizes"]["z"]["url"] if !image_url and data["sizes"]["z"] #640

debugger    

    return false    if !image_url
    
    rating        = data['fave_count'].to_i
    return false    if rating < 100
    
    desc          = data["description"]
    desc          = desc.gsub("\n", "<br>") if desc
    author_name   = doc.css(".photo-name-line-1 a").text.strip
    old_tags      = doc.xpath('//meta[@name="keywords"]/@content').map(&:value)[0]
    tags_array    = data['tags'].collect { |h| h["raw"] }.uniq
    view_count    = doc.css(".full-text")[0].text.strip[0..-7].gsub(",", "").to_i
    categories    = ""
    
    if author_name.blank? 
      if doc.css('.postdetailstop h2 a').size > 1
        author_name   = doc.css('.postdetailstop h2 a')[1].text.strip
      else
        author_name = "Unknown"
      end
    end

    user = add_user author_name
    
    photo = Photo.find_by(image_remote_id: image_id)
    if photo   
      existing = true   
      logger.info "updating photo #{photo.id} user=#{user} cat=#{categories} rating=#{rating} views=#{view_count} #{image_url} "
    else
      existing = false
      logger.info "adding photo user=#{user} cat=#{categories} rating=#{rating} views=#{view_count} #{image_url}"
      photo = Photo.new 
      photo.image_remote_id   = image_id
      photo.image_remote_url  = image_url
      photo.image_url         = image_url  
    end
    
    photo.title             = title
    photo.body              = desc
    photo.user              = user 
    photo.image_referer_url = url  
    photo.rating            = rating
    photo.base_view_count   = view_count
    photo.taken_at          = taken_at
    photo.tag_list          = remove_accent tags_array.join(", ")
    photo.category_list     = categories
    photo.save

    @@added_photos = @@added_photos + 1
  end
     
end

