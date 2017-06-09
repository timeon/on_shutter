require 'open-uri'

class NilClass
  def nil_or_empty?
    true
  end
end

class String
  def nil_or_empty?
    empty?
  end
  
  def to_ascii
    self.gsub("\0", ""); 
  end

  def starts_with_number
    self[0] >= 49 and self[0] <= 59  
  end  
end

class Contact < ActiveRecord::Base
  belongs_to        :user
  
  has_attached_file :photo, :styles => {:tiny=>"80x60#", :thumb=> "300x300>", :large => "1024x768>" }, 
                            :default_url => "/images/cbc_logo.jpg",
                            :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                            :url => "/system/:attachment/:id/:style/:filename"

  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  validates_presence_of :adult_1_first_name
  validates_presence_of :adult_1_last_name
  
  validates_presence_of :street_no_and_name
  validates_presence_of :city
  validates_presence_of :state
  
  validates_presence_of :zip
  #validates_numericality_of :zip
  #validates_length_of :zip, :is => 5
  
  #validates_presence_of :home_phone
  #validates_uniqueness_of :adult_1_email
  
  validates :adult_1_chinese_name, :uniqueness => { :scope => :adult_1_last_name}
    
  #validates_numericality_of :home_phone
  #validates_length_of   :home_phone, :is => 10
  #validates_presence_of :photo_number, :if => :no_photo_file?, :message => "or photo file needed"
  
  RELATIONS = ["child", "mom", "dad", "grandma", "grandpa", "uncle", "aunt", "grandson", "granddaugher"]
  COUNTRIES = ["US", "China", "Others"]
  
  def no_photo_file?
    !photo_file_name and verified
  end  
  
  def shadow
    thumb_file = "system/photos/#{id}/thumb/#{photo_file_name}"
    temp_file  = "/tmp/showdowed_image"
    cmd = "convert #{thumb_file} \\( +clone -background black -shadow 60x5+10+10 \\) +swap -background white -layers merge +repage #{temp_file}"
    `#{cmd}`
    cmd = "cp #{temp_file} #{thumb_file}"
    `#{cmd}`
  end
  
  def before_save
    if key == nil
      self.key = (rand * 100000000000).round  
    end
    
    self.home_phone    = self.home_phone.tr("^0-9", "")    if home_phone and us?
    self.adult_1_phone = self.adult_1_phone.tr("^0-9", "") if adult_1_phone and us?
    self.adult_2_phone = self.adult_2_phone.tr("^0-9", "") if adult_2_phone and us?

    self.home_phone    = nil if home_phone    and home_phone.length    == 0
    self.adult_1_phone = nil if adult_1_phone and adult_1_phone.length == 0
    self.adult_2_phone = nil if adult_2_phone and adult_2_phone.length == 0

    self.adult_1_first_name = self.adult_1_first_name.tr("^A-Za-z", "").capitalize if adult_1_first_name 
    self.adult_1_last_name  = self.adult_1_last_name.tr("^A-Za-z",  "").capitalize if adult_1_last_name

    self.adult_2_first_name = self.adult_2_first_name.tr("^A-Za-z", "").capitalize if adult_2_first_name
    self.adult_2_last_name  = self.adult_2_last_name.tr("^A-Za-z",  "").capitalize if adult_2_last_name

    self.child_1_first_name = self.child_1_first_name.tr("^A-Za-z", "").capitalize if child_1_first_name
    self.child_1_last_name  = self.child_1_last_name.tr("^A-Za-z",  "").capitalize if child_1_last_name

    self.child_2_first_name = self.child_2_first_name.tr("^A-Za-z", "").capitalize if child_2_first_name
    self.child_2_last_name  = self.child_2_last_name.tr("^A-Za-z",  "").capitalize if child_2_last_name

    self.child_3_first_name = self.child_3_first_name.tr("^A-Za-z", "").capitalize if child_3_first_name
    self.child_3_last_name  = self.child_3_last_name.tr("^A-Za-z",  "").capitalize if child_3_last_name

    self.child_4_first_name = self.child_4_first_name.tr("^A-Za-z", "").capitalize if child_4_first_name
    self.child_4_last_name  = self.child_4_last_name.tr("^A-Za-z",  "").capitalize if child_4_last_name

    self.child_5_first_name = self.child_5_first_name.tr("^A-Za-z", "").capitalize if child_5_first_name
    self.child_5_last_name  = self.child_5_last_name.tr("^A-Za-z",  "").capitalize if child_5_last_name
    
    self.adult_1_first_name = nil if adult_1_first_name and adult_1_first_name.length == 0
    self.adult_2_first_name = nil if adult_2_first_name and adult_2_first_name.length == 0
    
    self.adult_1_last_name = nil if adult_1_last_name and adult_1_last_name.length == 0
    self.adult_2_last_name = nil if adult_2_last_name and adult_2_last_name.length == 0
    
    self.adult_1_chinese_name = nil if adult_1_chinese_name and adult_1_chinese_name.length == 0
    self.adult_2_chinese_name = nil if adult_2_chinese_name and adult_2_chinese_name.length == 0

    self.child_1_first_name = nil if child_1_first_name and child_1_first_name.length == 0
    self.child_2_first_name = nil if child_2_first_name and child_2_first_name.length == 0
    self.child_3_first_name = nil if child_3_first_name and child_3_first_name.length == 0
    self.child_4_first_name = nil if child_4_first_name and child_4_first_name.length == 0
    self.child_5_first_name = nil if child_5_first_name and child_5_first_name.length == 0
    
    self.child_1_last_name = nil if child_1_last_name and child_1_last_name.length == 0
    self.child_2_last_name = nil if child_2_last_name and child_2_last_name.length == 0
    self.child_3_last_name = nil if child_3_last_name and child_3_last_name.length == 0
    self.child_4_last_name = nil if child_4_last_name and child_4_last_name.length == 0
    self.child_5_last_name = nil if child_5_last_name and child_5_last_name.length == 0

    self.child_1_chinese_name = nil if child_1_chinese_name and child_1_chinese_name.length == 0
    self.child_2_chinese_name = nil if child_2_chinese_name and child_2_chinese_name.length == 0
    self.child_3_chinese_name = nil if child_3_chinese_name and child_3_chinese_name.length == 0
    self.child_4_chinese_name = nil if child_4_chinese_name and child_4_chinese_name.length == 0
    self.child_5_chinese_name = nil if child_5_chinese_name and child_5_chinese_name.length == 0
  end
  
  def after_save
    #ContactMailer.updated_contact(self).deliver
  end

  def self.create_from_lines(lines)
    contact = Contact.new
    line_count = 1
    
    lines.each do |line|
      #puts "#{line_count} : #{line}"
      case line_count
        when 1
          contact.parse_chinese_names(line)
        when 2
          contact.home_phone = line.to_ascii 
        when 3
          contact.parse_english_names(line)
        when 4
          if line.starts_with_number  
            contact.street_no_and_name = line.to_ascii.gsub(",", ", ")
            line_count = line_count + 1
          else    
            contact.parse_children_names(line)
          end
        when 5
          contact.street_no_and_name = line.to_ascii.gsub(",", ", ") 
        when 6
          contact.parse_city_state_zip(line)
        when 7
          contact.parse_email_cell_phone_photo(line)
        when 8
          contact.parse_email_cell_phone_photo(line)
        when 9
          contact.parse_email_cell_phone_photo(line)
        when 10
          contact.parse_email_cell_phone_photo(line)
        when 11
          contact.parse_email_cell_phone_photo(line)
      end
      
      line_count = line_count + 1  
    end
    
    return contact
  end

  def parse_chinese_names(line)
    names = line.split(" ")[0].split(",")
    self.adult_1_chinese_name = names[0]
    self.adult_2_chinese_name = names[1]
  end

  #BAO,Xingfeng & Ying DONG
  def parse_english_names(line)
    names = line.split(" & ")

    n = names[0].split(",")
    self.adult_1_last_name = n[0].capitalize
    self.adult_1_first_name = n[1].capitalize

    if names[1]
      n = names[1].split(" ")
      self.adult_2_first_name = n[0].capitalize
      self.adult_2_last_name = n[1] || self.adult_1_last_name.capitalize
    end   
  end
  
  def parse_children_names(line)
    names = line.split(",")
    self.child_1_first_name, self.child_1_last_name = parse_child_name(names[0]) if !!names[0] 
    self.child_2_first_name, self.child_2_last_name = parse_child_name(names[1]) if !!names[1] 
    self.child_3_first_name, self.child_3_last_name = parse_child_name(names[2]) if !!names[2] 
    self.child_4_first_name, self.child_4_last_name = parse_child_name(names[3]) if !!names[3] 
    self.child_5_first_name, self.child_5_last_name = parse_child_name(names[4]) if !!names[4] 
  end

  def parse_child_name(name)
    n = name.split(" ")
    first_name = n[0]
    last_name = n[1] || self.adult_1_last_name
    return first_name, last_name    
  end

  def parse_city_state_zip(line)
    names = line.split(",")
    self.city  = names[0]
    self.state = names[1].split(" ")[0]
    self.zip   = names[1].split(" ")[1]
  end
  
  def parse_email_cell_phone_photo(line)
    if line.include?("@")
      parse_email(line)
    elsif line.length > 3
      parse_cell_phone(line)
    else
      parse_photo_id(line)  
    end    
  end

  def parse_email(line)
    if self.adult_1_email 
       self.adult_2_email = line.to_ascii.downcase
    else
       self.adult_1_email = line.to_ascii.downcase
    end
  end  
  
  def parse_cell_phone(line)
    if self.adult_1_phone 
       self.adult_2_phone = line.to_ascii
    else
       self.adult_1_phone = line.to_ascii
    end
  end  

  def parse_photo_id(line)
    photo_id = line.to_ascii.downcase  
    self.photo = File.open("/home/bwang/church_directory_photo/matched/image#{photo_id}.jpg")
  end  

  def adult_2?
    !adult_2_first_name.nil_or_empty?
  end

  def child_1?
    !child_1_first_name.nil_or_empty? or !child_1_chinese_name.nil_or_empty?
  end
  
  def child_2?
    !child_2_first_name.nil_or_empty? or !child_2_chinese_name.nil_or_empty?
  end
  
  def child_3?
    !child_3_first_name.nil_or_empty? or !child_3_chinese_name.nil_or_empty?
  end
  
  def child_4?
    !child_4_first_name.nil_or_empty? or !child_4_chinese_name.nil_or_empty?
  end
  
  def child_5?
    !child_5_first_name.nil_or_empty? or !child_5_chinese_name.nil_or_empty?
  end
  
  def us?
    country == "US"  
  end
  
  
  def to_s
    display = "\n===============================================\n"        
    display += "adult 1: #{adult_1_chinese_name}|#{adult_1_first_name}|#{adult_1_last_name}|#{adult_1_email}|#{adult_1_phone}|\n"        
    display += "adult 2: #{adult_2_chinese_name}|#{adult_2_first_name}|#{adult_2_last_name}|#{adult_2_email}|#{adult_2_phone}|\n" if adult_2?        
    display += "addr   : #{street_no_and_name}|#{city}, #{state} #{zip}|#{home_phone}|\n"        
    display += "child 1: #{child_1_first_name}|#{child_1_last_name}|\n"  if child_1?         
    display += "child 2: #{child_2_first_name}|#{child_2_last_name}|\n"  if child_2?         
    display += "child 3: #{child_3_first_name}|#{child_3_last_name}|\n"  if child_3?  
    display += "child 4: #{child_4_first_name}|#{child_4_last_name}|\n"  if child_4?          
    display += "child 5: #{child_4_first_name}|#{child_5_last_name}|\n"  if child_5?  
    display += "----------------------------------------------\n"        
  end

  def chinese_names
   names = adult_1_chinese_name || adult_1_first_name  
   if names and adult_2?
     names += ", "
     names += adult_2_chinese_name || adult_2_first_name || ""
   end  
   names   
  end

  def english_names
   names = adult_1_last_name.upcase + ", " + adult_1_first_name  
   if adult_2?
     names += " & " + adult_2_first_name
     if(adult_1_last_name != adult_2_last_name)
       names += " " + adult_2_last_name.upcase;
     end  
   end  
   names   
  end

  def names
    if adult_1_first_name and adult_2_first_name  
      names = "#{adult_1_first_name} and #{adult_2_first_name}"
    elsif adult_1_email 
      names = "#{adult_1_first_name}"
    elsif adult_2_email 
      names = "#{adult_2_first_name}"
    else
      names = nil
    end            
  end
  
  def emails
    if !adult_1_email.nil_or_empty? and !adult_2_email.nil_or_empty?  
      emails = "#{adult_1_first_name} #{adult_1_last_name}<#{adult_1_email}>, #{adult_2_first_name} #{adult_2_last_name} <#{adult_2_email}>"
    elsif !adult_1_email.nil_or_empty?
      emails = "#{adult_1_first_name}  #{adult_1_last_name}<#{adult_1_email}>"
    elsif !adult_2_email.nil_or_empty? 
      emails = "#{adult_2_first_name}  #{adult_2_last_name}<#{adult_2_email}>"
    else
      emails = nil
    end            
  end
  
  def children
   children = ""
   
   if child_1?
     if child_1_relation != "child"
       children += "#{child_1_first_name} #{child_1_last_name} #{child_1_chinese_name}(#{child_1_relation})"
     else    
       children += child_1_first_name || ""
       children += " " + child_1_last_name  if child_1_last_name and adult_1_last_name and child_1_last_name != adult_1_last_name
     end
   end  
   
   if child_2?
     children += ", "
     if child_2_relation != "child"
       children += "#{child_2_first_name} #{child_2_last_name} #{child_2_chinese_name}(#{child_2_relation})"
     else    
       children += child_2_first_name || ""
       children += " " + child_2_last_name  if child_2_last_name and adult_1_last_name and child_2_last_name != adult_1_last_name
     end
   end  
   
   if child_3?
     children += ", "
     if child_3_relation != "child"
       children += "#{child_3_first_name} #{child_3_last_name} #{child_3_chinese_name}(#{child_3_relation})"
     else    
       children += child_3_first_name || ""
       children += " " + child_3_last_name  if child_3_last_name and adult_1_last_name and child_3_last_name != adult_1_last_name
     end
   end  
      
   if child_4?
     children += ", "
     if child_4_relation != "child"
       children += "#{child_4_first_name} #{child_4_last_name} #{child_4_chinese_name}(#{child_4_relation})"
     else    
       children += child_4_first_name || ""
       children += " " + child_4_last_name  if child_4_last_name and adult_1_last_name and child_4_last_name != adult_1_last_name
     end
   end  
   
   if child_5?
     children += ", "
     if child_5_relation != "child"
       children += "#{child_5_first_name} #{child_5_last_name} #{child_5_chinese_name}(#{child_5_relation})"
     else    
       children += child_5_first_name || ""
       children += " " + child_5_last_name  if child_5_last_name and adult_1_last_name and child_5_last_name != adult_1_last_name
     end
   end  
   
   return children     
  end
     
end
