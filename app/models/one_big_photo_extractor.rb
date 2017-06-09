module OneBigPhotoExtractor
  include PhotoExtractor
    
  def process_obp(url)
    if    url == "update onebigphoto galleries"
      update_obp_galleries
    elsif url == "update onebigphoto"
      update_obp
    elsif url.include? "onebigphoto.com"
      crawl_obp url.split(" ")[0], url.split(" ").size > 1 ? url.split(" ")[1].to_i : 5  
    end
  end  
  
  def crawl_obp(url, pages)
    last_last_url = nil
    last_url = nil 
    
    i = 0
    begin
       last_last_url = last_url 
       last_url = url 
       url = process_obp_page(url)
       if url == last_url and last_url == last_last_url
         break
       end 
       sleep(5 + Random.rand(10)) if Rails.env.production?
       i = i + 1
    end while url and !@e and i < pages
    
  end
    
  def update_obp
    @photos = Photo.where('user_id is null or rating=0 or base_view_count=0 and image_referer_url is not null and image_referer_url like "%onebigphoto.com%" and length(title) > 40')
    @photos.each do |photo|
      
      process_obp_page(photo.image_referer_url) if ! photo.image_referer_url.blank? 
    end
    
  end
    
    
  def update_obp_galleries
    update_obp_galleries_page("http://onebigphoto.com/category/top-galleries/page/3/")    
    update_obp_galleries_page("http://onebigphoto.com/category/top-galleries/page/4/")    
    update_obp_galleries_page("http://onebigphoto.com/category/top-galleries/page/5/")    
    update_obp_galleries_page("http://onebigphoto.com/category/top-galleries/")
    update_obp_galleries_page("http://onebigphoto.com/category/top-galleries/page/2/")    
  end
      
  def update_obp_galleries_page(url)
    logger.info "url = #{url}"   
    doc = Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36"))

    gallery_links = doc.css('.wrapper .postlist a')
    gallery_links.each do |gallery_link|
      process_obp_gallery_page(nil, gallery_link['href'])      
    end 
  end
    
  def process_obp_page(url)
    logger.info "url = #{url}"   
    begin
      
      doc = Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36"))
  
      next_links = doc.css('.singlepost .postcontents a') 
      random_links = doc.css('.headerline .wrapper .buttons a')
      is_gallery = doc.css('.postcontents div').count > 1
  
      if is_gallery
        # we have come to a gallery page with multiple photos
        end_sequence = process_obp_gallery_page(doc, url)
      else
        end_sequence = process_obp_photo_page(doc, url)
      end  
  
      if end_sequence
          next_page_url = nil
      elsif next_links and next_links[0]  
        path = next_links[0]['href']
        if !path or path.include? "http"
          next_page_url = nil
        else  
          next_page_url = "http://onebigphoto.com" +  next_links[0]['href']
        end  
      end   
        
      if next_page_url == url or next_page_url == nil
        if random_links and random_links[0]
          logger.info "existing or last page, get a random page"
          next_page_url = random_links[0][:href]
        else
          logger.info "no random page - get out"
          next_page_url = nil  
        end 
      end
    rescue => e
      logger.warn "Will ignore: #{e}" 
    end  
      
    next_page_url
  end

  def process_obp_photo_page(doc, url)
debugger
    image_url     = doc.css('.postcontents a img')[0]['src']
    title         = doc.css('.postdetailstop h1')[0].text.strip.titleize
    author_name   = doc.css('.postdetailstop h2 a').text.strip
    rating        = doc.css('.ratingtext strong').text.to_i
    view_count    = doc.css('.postdetails .postdetailsbottom .views').text.gsub(" ", "").to_i

    if author_name.blank? 
      if doc.css('.postdetailstop h2 a').size > 1
        author_name   = doc.css('.postdetailstop h2 a')[1].text.strip
      else
        author_name = "Unknown"
      end
    end
     
    categories    = doc.css('.catsandtags h3 a').text.gsub("photography", "photography,").titleize
    tags          = doc.css('.catsandtags span').text[20, 100].strip

    user = add_user author_name
    
    photo = Photo.find_by(image_remote_url: image_url)
    if photo   
      existing = true   
      logger.info "updating photo #{photo.id} user=#{user} tags=#{tags} cat=#{categories} rating=#{rating} views=#{view_count} #{image_url} "
    else
      existing = false
      logger.info "adding photo user=#{user} tags=#{tags}cat=#{categories} rating=#{rating} views=#{view_count} #{image_url}"
      photo = Photo.new 
      photo.image_remote_url  = image_url
      photo.image_url         = image_url  
    end
    
    photo.title             = title
    photo.user              = user 
    photo.image_referer_url = url  
    photo.rating            = rating
    photo.base_view_count   = view_count
    
    photo.tag_list.add(tags, parse: true)
    photo.category_list.add(categories, parse: true)
    photo.save

    existing
  end


  def process_obp_gallery_page(doc, url)
debugger    
    if !doc
      doc = Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36"))
    end
    
    gallery_name  = doc.css('.postdetailstop h1')[0].text.titleize
    
    images        = doc.css('.singlepost .postcontents .wp-caption img')
    titles        = doc.css('.singlepost .postcontents .wp-caption p')
    
    categories    = doc.css('.catsandtags h3 a').text.gsub("photography", "photography,").titleize
    tags          = doc.css('.catsandtags span').text[20, 100].strip

    i = 0
    begin
      image_url = images[i][:src]
      parts      = titles[i].text.split("Photo by")
      if parts.size >= 2
        desc = parts[0].strip
        author_name = parts[1].gsub(":", " ").strip
      end

      user = add_user author_name

      if image_url == "http://onebigphoto.com/uploads/2013/12/photooftheyear.jpg"
        i = i + 1
        next
      end
      photo = Photo.find_by(image_remote_url: image_url)
      if photo
        logger.info "existing gallery photo  collection=#{gallery_name} #{photo.id} #{image_url}"   
      else
        logger.info "adding gallery photo collection=#{gallery_name} #{image_url}"   
        photo = Photo.new
        photo.image_remote_url  = image_url
        photo.image_referer_url = url  
        photo.image_url         = image_url  
        sleep(5 + Random.rand(10))  if Rails.env.production?
      end
      
      photo.body = desc
      photo.user  = user 
      photo.collection_list.add(gallery_name, parse: true)
      photo.save

      idstr = image_url.split('/')[-1].split('.')[0].gsub('-of-', '-')
      photo_page_url = "http://onebigphoto.com/" +  idstr
      process_obp_page(photo_page_url)
      
      i = i + 1
      
    end while i < images.size and i < titles.size     
    
    true # end of sequence
  end
     
end
