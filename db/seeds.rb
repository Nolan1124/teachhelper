# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  
teachers = [{:t_id => 10010, :username => '张三', :password => '12345', :eamil => '1096221714@qq.com', :gmt_time => ''},
    	  {:t_id => 10011, :username => '胡歌', :password => '12345', :eamil => '22435221715@qq.com', :gmt_time => ''},
  	 ]
teachers.each do |teacher|
  Teacher.create!(teacher)
end

courses = [{:c_id => 10010, :t_id => 10010, :cname => '数据挖掘', :year => 2017, :season => 0, :gmt_time => ''},
    	  {:c_id => 10011, :t_id => 10011, :cname => '算法设计', :year => 2017, :season => 1, :gmt_time => ''},
  	 ]
courses.each do |course|
  Course.create!(course)
end

assignments = [{:a_id => 2017001, :course_id => 10010, :description => '描述软件工程的定义', :a_secret_key => 'At_iduuid', :gmt_time => '2017-09-10'},
    	  {:a_id => 2017002, :course_id => 10011, :description => '描述体系结构的定义', :a_secret_key => 'At_iduuid', :gmt_time => '2017-09-21'},
  	 ]
assignments.each do |assignment|
  Assignment.create!(assignment)
end
