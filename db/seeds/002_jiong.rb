
@jiong = User.create({
  :login => 'jiong', 
  :email => 'jinwolaisi@gmail.com',
  :real_name => 'Xiangjiong Wang',
  :name => 'Jiong',
  :location => 'Shenzhen, China',
  :password => 'jiongjiong'})
@jiong.save
