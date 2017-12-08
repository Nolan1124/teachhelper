# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  
teachers = [{:id => 10010, :username => '张三', :password => '12345', :eamil => '1096221714@qq.com', :gmt_time => ''},
    	  {:id => 10011, :username => '胡歌', :password => '12345', :eamil => '22435221715@qq.com', :gmt_time => ''},
  	 ]
teachers.each do |teacher|
  Teacher.create!(teacher)
end
