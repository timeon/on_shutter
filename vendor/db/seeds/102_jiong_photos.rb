photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/_DSC0537.JPG'),
  :title => "The models",
  :description => ''})
photo.save

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Interesting study of the two sides of a show window. Which side is more real? The unique silhouetted figure, unlike most window shoppers, was not shy to strike back with a bold pose."})
@jiong.vote_for(critique)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/IMG_2532.jpg'),
  :title => "Village in a winter morning.",
  :description => 'A senior sitting on the edge of a grain roller, smoking a pipe, while surveying his village in a winter morning. A usual sence of the region in northern Shaaxi province, China.'})
photo.save
@bryan.favorite_photos << photo

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => 'Nice composition depicting a simple village life.'})

@jiong.vote_for(critique)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSQ_5474.jpg'),
  :title => "Flowers and earth",
  :description => ''})
photo.save

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => 'Striking image depicting the life cycle of a plant, emphasizing on the withered flower going back to the earth and the root of the plant.'})
@jiong.vote_for(critique)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/_DSC3290.jpg'),
  :title => "Painted Chinese corridor",
  :description => ''})
photo.save

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => 'Terrific shot. Is it a tunnel through space, or time?'})
@jiong.vote_for(critique)



# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/_DSC2371.JPG'),
  :title => "Lotus",
  :description => ''})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => 'Nice contrast of the brilliant flower and the dimmed pad in the backround, the bud is a nice addition to the elegant and simple composition.'})
@jiong.vote_for(critique)



# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_0062.JPG'),
  :title => "Hide and Seek",
  :description => "You can't find me."})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Vivid image of a lively boy hiding behind a tree trunk. Great shot on capturing the boy's pose and facial expression, which works in harmony to form the drama. Leaving half of the figure in the shadow makes the scene more dramatic. Superb image!"})
@jiong.vote_for(critique)



# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_0286.jpg'),
  :title => "Flower",
  :description => ''})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => 'Surreal image of graceful shape and color of a flower just blommed. The shalow field gives a dream-like impression.'})
@jiong.vote_for(critique)



# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_1372_012.jpg'),
  :title => "Water drop on lily pad",
  :description => ''})
photo.save
@bryan.vote_for(photo)



# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_2833.JPG'),
  :title => "Zhou Village",
  :description => 'The watershed Zhou Village near Shanghai'})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Nice composition with the relfections in the water. The half moon bridge is especially interesting."})
@jiong.vote_for(critique)




# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_3048.JPG'),
  :title => "Shenzhen in the morning sun",
  :description => ''})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Impressive display of colors in the morning. Rich shades of warm colors on the buildings stand out yet stay in harmony with the equally rich display of blues in the sky. The photographer is clearly a master of the physics and arts of the morning light."})
@jiong.vote_for(critique)




# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_3461.JPG'),
  :title => "Bread",
  :description => ''})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Whatever they are, my waterting mouth is ready to consume them. Nice color and great comp."})
@jiong.vote_for(critique)




# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_3705.JPG'),
  :title => "Shenzhen at night",
  :description => ''})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Another exquisite study of the colors at night. In stead of heavy brushes on the city light in most urban night pictures, the photographer tilted his len upward and takes the viewer to a different perspective, a larger picture."})
@jiong.vote_for(critique)




# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_3984 2.jpg'),
  :title => "Powerline towers",
  :description => ''})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Usually treated as messy objects to be avoided, the powerline towers are the very subject of this study. The shape, structure, and <i>personality</i> of the towers are interesting and beatiful, and enhanced through repeatition. Even the electricity lines become someting of elegance.<br><br>The background composed of the lively sky and vegetations live with the powerlines in harmony.<br><br>"})
@jiong.vote_for(critique)



# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_7623.JPG'),
  :title => "A bowl of veggie noodle",
  :description => ''})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSC_9663.JPG'),
  :title => "Lights in a bar",
  :description => ''})
photo.save
@bryan.vote_for(photo)

critique = Critique.create({
  :user  => @bryan, 
  :photo => photo,
  :body => "Intrigue image of light and darkness. The silhouetted figure walking out of the door of the bar adds a subtle meaning to the picture."})


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSQ_5103.jpg'),
  :title => "Lone egret",
  :description => ''})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSQ_5222 7.jpg'),
  :title => "Lotus",
  :description => ''})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSQ_9205.JPG'),
  :title => "flowers",
  :description => 'Beautifully dressed lotus and girl.'})
photo.save
@bryan.vote_for(photo)



# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSQ_9229.JPG'),
  :title => "girl",
  :description => ''})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/DSQ_9846.JPG'),
  :title => "lotus and girls in the rain",
  :description => ''})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/Anchor.jpg'),
  :title => "Anchor",
  :description => "Master, thanks for the game."})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/Coming and going.jpg'),
  :title => "Coming and going",
  :description => ""})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/Seeds hall.jpg'),
  :title => "Seeds hall",
  :description => ""})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/Chrysanthemum.jpg'),
  :title => "Chrysanthemum",
  :description => ""})
photo.save
@bryan.vote_for(photo)



# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/A little girl in red.jpg'),
  :title => "A little girl in red",
  :description => ""})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/a bird.jpg'),
  :title => "a bird",
  :description => ""})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/yellow Roses.jpg'),
  :title => "yellow Roses",
  :description => ""})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/lotus in dream.jpg'),
  :title => "lotus in dream",
  :description => ""})
photo.save
@bryan.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @jiong, 
  :image => File.open('/home/bwang/photos/jiong/lotus in rainstorm.jpg'),
  :title => "lotus in rainstorm",
  :description => ""})
photo.save
@bryan.vote_for(photo)

