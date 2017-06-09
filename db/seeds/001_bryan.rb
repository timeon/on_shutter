@bryan = User.create({
  :login => 'bryan', 
  :email => 'timeon@gmail.com',
  :real_name => 'Bryan Wang',
  :name => 'Bryan Wang',
  :website => 'www.OnShutters.com',
  :location => 'San Diego',
  :about_me => 'Developer of this site. Truth seeker. Advocate of technology.<br><br>Enjoy taking pictures of people and appreciating photos of all kinds',
  :password => 'bryanbryan'})
@bryan.save

@bryan = User.find_by_login('bryan') if @bryan == nil
