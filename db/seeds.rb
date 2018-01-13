# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

teachers = [{ :username => '刘欢', :password => '123456', :email => '1096221718@qq.com', :gmt_time => ''},
    	  { :username => '胡歌', :password => '123456', :email => '22435221715@qq.com', :gmt_time => ''},
  	 ]
teachers.each do |teacher|
  Teacher.create!(teacher)
end

courses = [{:teacher_id => 10010, :name => '软件工程', :gmt_time => ''},
    	  {:teacher_id => 10011, :name => '算法设计', :gmt_time => ''},
  	 ]
courses.each do |course|
  Course.create!(course)
end

assignments = [{ :course_id => 1, :content => '1.软件工程定义？A软件B工程##2.软件的作用A玩B学习', :answer => "AB", :secret_key => 'At_iduuid', :gmt_time => '2018-01-13'},
  	 ]
assignments.each do |assignment|
  Assignment.create!(assignment)
end
