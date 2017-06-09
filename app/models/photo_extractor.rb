module PhotoExtractor
  require 'uri'
  @@user_agent = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36"
    
  def add_user(author_name)
    login = I18n.transliterate(author_name).downcase.gsub(" ", "_").gsub("@", "").gsub("|", "_").gsub(".", "_").gsub("__", "_")[0..39]
    user_name = login.gsub("_", ".")
    email = user_name + '@user.onshutters.com'
    user = User.find_by(email: email)
    if !user
      logger.info "adding user #{login} #{user_name}"   
      user = User.new
      user.login      = login
      user.email      = email
      user.real_name  = author_name.titleize
      user.name       = author_name.titleize
      user.password   = login + "password"
      user.save
    else
      logger.info "existing user #{user.id} #{login} #{user_name}"   
    end
    
    user
  end

  def remove_accent str     
    str.tr(
    "ÀÁÂÃÄÅàáâãäåĀāĂăĄąßÇçĆćĈĉĊċČčÐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøồŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšſŢţŤťŦŧÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž",
    "AAAAAAaaaaaaAaAaAabCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOoooooooOoOoOoRrRrRrSsSsSsSssTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")
  end
  
end
