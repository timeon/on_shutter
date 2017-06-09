@contact_lines = Array.new
line_counter = 1
@contact_counter = 1

file = File.open("db/seeds/directory_2011.txt", "r:utf-8")

while (line = file.gets)
    line = line.gsub("\r\n",  "")
    line_counter = line_counter + 1

    if (line.length == 0)
      @contact = Contact.create_from_lines(@contact_lines)

      if @contact.save
        puts "contact ##{@contact_counter} OK"
      else
        puts @contact
        puts "contact ##{@contact_counter} NOK"
      end
        
      @contact_counter = @contact_counter + 1
      
      @contact_lines = Array.new
    else
      @contact_lines << line
    end
end

file.close
