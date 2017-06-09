# self portrait http://www.pbase.com/haibohuang/image/109347214

# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o2/93/895893/1/124787104.ZrYaUwpM.HHB100407_183130.jpg',
  :title => 'Roadside oak at sunset',
  :body => 'This picture was taken at a highway rest stop, sunset at Trinity National Forest along Route 299 en-route to Redding'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)
@bryan.favorite_photos << photo

    critique = Critique.create({
      :user  => @bryan, 
      :photo => photo,
      :body => 'Wonderful silhouette and very beautiful tone. This is absolutely sumptuous! Fine photography!!!'})
    @haibo.vote_for(critique)


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/114443547.FslNILTq.HHB080211_130808.jpg',
  :title => 'Horseshoe Bend',
  :body => 'a few miles south of Page, Arizona, down the stream from Glen Canyon Dam'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)
@bryan.favorite_photos << photo

    critique = Critique.create({
      :user  => @bryan, 
      :photo => photo,
      :body => 'Wonderful shot of Horseshoe, splendid colors and perspective. Vote'})

    critique = Critique.create({
      :user  => @xiang, 
      :photo => photo,
      :body => 'Each time i see this i want to go there. Your picture is beautiful. Marvellous light.'})


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o4/93/895893/1/108629004.N856gcu5.DSC_2024.jpg',
  :title => 'Mother and daughter',
  :body => 'Using tele-photo as a portrait lens during travel.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108626910.1cVBgizV.ArcadiaSunrise.jpg',
  :title => 'Acadia Sunrise',
  :body => 'Sunrise over cloud covered ocean in Acadia National Park'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

    critique = Critique.create({
      :user  => @bryan, 
      :photo => photo,
      :body => "Beautiful. Tough it's a simple composition, the tones, being above the clouds, the moment, and the way you frame your composition makes it a really good picture."})



# ##############
photo = Photo.create({
  :user  => @haibo, 
  
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108627134.gWyjN5FW.VermontImpression.jpg',
  :title => 'Vermont Impression',
  :body => 'After 3 hours of drive from Boston and 1 hour of waiting in the darkness, the first sun rays unveiled the magic of New England foliage season.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108627019.c6q3O4xv.GoldenMemory1.jpg',
  :title => 'Golden Memory',
  :body => 'Cottonwood Canyon in California central valley amids the blossoming desert wild flowers, watching the boys lost in their own little world is reminescent of the idealized notion of "Golden Childhood".'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108627068.f2yP9BZ8.MistyMountains.jpg',
  :title => 'Misty Mountains',
  :body => 'Sunrise over misty mountains near the southern entrance of Sequoia National Park.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

    critique = Critique.create({
      :user  => @bryan, 
      :photo => photo,
      :body => 'Splendid image and nice composition with rich display of colors.'})

# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/110302031.2TkNVNxi.WaterFallinWhiteMountains.jpg',
  :title => 'Water Fall in White Mountain',
  :body => ''})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o2/93/895893/1/129987511.EDYRVVlX.HHB_100903_071205.jpg',
  :title => 'LuJiaZhui, Pudong',
  :body => 'Using tripod to create motion effect of the cloud'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o4/93/895893/1/130597212.EGaJMrfk.HHB_100902_073047.jpg',
  :title => 'China Pavilion in 2010 World Expo',
  :body => 'Using wide-angle for drama.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108627082.SVL86Gv9.NewEnglandVillage1.jpg',
  :title => 'New England Village',
  :body => 'Small village in Vermont in early morning.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108627132.uXkqk3in.SunsetoverPacificOcean2.jpg',
  :title => 'Sunset over Pacific Ocean',
  :body => 'Off Highway 1 along the California coast.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

    critique = Critique.create({
      :user  => @bryan, 
      :photo => photo,
      :body => 'Nice picture augmenting the pervailing sunset colors of the sky reflected in the water.'})


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108627002.IPIkuPav.CharlesRiverSunset.jpg',
  :title => 'Charles River Sunset',
  :body => "Harvard's rowing team practicing on the Charles river."})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108657332.240X0GO6.ThreeMonthsOld.jpg',
  :title => 'Three Months Old',
  :body => '.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

    critique = Critique.create({
      :user  => @bryan, 
      :photo => photo,
      :body => 'Great job on producing a sense of natural lighting by using flash'})


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o3/93/895893/1/112346766.t0ep6fHq.HHB090405_123850.jpg',
  :title => 'Girl with butterfly',
  :body => '.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108657320.7icjESoT.ThreeGoodFriends1.jpg',
  :title => 'Friends',
  :body => '.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108657319.oofFMhwz.TheSlideisTooTall.jpg',
  :title => 'Boy in diaper',
  :body => '.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108698734.JBHyMgJU.PianoRecital1.jpg',
  :title => 'Piano Recital',
  :body => ''})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

  critique = Critique.create({
    :user  => @bryan, 
    :photo => photo,
    :body => 'Nice contrast between black and white, massive and small. Great comp'})


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o6/93/895893/1/108698704.99QRHyjI.Lecture.jpg',
  :title => 'Lecture',
  :body => '.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

    critique = Critique.create({
      :user  => @bryan, 
      :photo => photo,
      :body => 'Great shot with avaiable light. Great composition!'})



# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o4/93/895893/1/110829534.Ox9s3x8O.InteriorDesign29.jpg',
  :title => 'Interior Design',
  :body => 'Using bounce flash to achieve balance with natural lighting'})
photo.save





# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o3/93/895893/1/111663984.1IOxBIXV.ViewfromCentralCampus.JPG',
  :title => 'View from Central Campus',
  :body => 'Scenic view of Rancho Penasquitos from Westview HS where the CBCSD central campus holds Sunday Services. This photography project starts with the purchase of my Nikon D70 camera, now continuing onto D300.'})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)


# ##############
photo = Photo.create({
  :user  => @haibo, 
  :image_url => 'http://i.pbase.com/o2/93/895893/1/120070428.ISboLAYL.HHB091010_045752.jpg',
  :title => "St. Olav's Church in Tallinn, Estonia",
  :body => "St. Olav's Church Steeple was for over a century (~15th century) the tallest structure in Europe."})
photo.save
@bryan.vote_for(photo)
@xiang.vote_for(photo)

