photo= Photo.create({
  :user  => @xiang, 
  :image => File.open('/home/bwang/photos/xiang/2009-12-23 17-05-38.jpg'),
  :title => 'Sand dune',
  :description => 'Sand dune in Death Valley'})
photo.save

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Nice color and contrast. I'd recomp to clean up the fuzzy foreground though."})
@xiang.vote_for(critique)

# ##############
photo = Photo.create({
  :user  => @xiang, 
  :image => File.open('/home/bwang/photos/xiang/2009-12-23 09-55-37.jpg'),
  :title => 'Road in Death Valley',
  :description => 'Road leading to the east entrance of Death Valley from Betty, Nevada'})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "The straight downward road leads to an uncentain end. I'd rather be on the opposite lane. Nice shot."})
@xiang.vote_for(critique)

# ##############
photo = Photo.create({
  :user  => @xiang, 
  :image => File.open('/home/bwang/photos/xiang/2010-02-04 09-09-46.jpg'),
  :title => 'Arched entrance in Ceasarea',
  :description => 'View from an ancient arched entrance to the stormy Febuary sky in Ceasarea, Israel'})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => 'Well balanced. Nice contrast of the darkness and light. The arched entrance provides a peek from the past to the present day.'})
@xiang.vote_for(critique)


# ##############
photo = Photo.create({
  :user  => @xiang, 
  :image => File.open('/home/bwang/photos/xiang/2008-09-06 06-31-03.jpg'),
  :title => 'Sunrise',
  :description => 'Sunrise at Mount Laguna, east of San Diego,'})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Well composed with nice color from the glorious rising sun silhouetting the rocks and the boy. Indepth study of the relationahip between nature and man. Not that I don't agree with the comp, but wondering what would come out if the boy's shihouete faces the sun?"})
@xiang.vote_for(critique)



# ##############
photo = Photo.create({
  :user  => @xiang, 
  :image => File.open('/home/bwang/photos/xiang/2010-08-12 11-17-21 2.jpg'),
  :title => 'Stone grain grinder',
  :description => 'Stone grain grinder, Shaanxi, China'})
photo.save
@bryan.vote_for(photo)



# ##############
photo = Photo.create({
  :user  => @xiang, 
  :image => File.open('/home/bwang/photos/xiang/2010-08-12 14-37-10.jpg'),
  :title => 'Gate to old school yard',
  :description => 'The gate to a deserted school yard in the lushing summer, Shaanxi, China'})
photo.save
@bryan.vote_for(photo)

