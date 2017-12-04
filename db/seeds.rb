# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

students = [{:sno => '201701', :sname => '张三', :sage => 23, :ssex => '男', :sdept => '计算机与控制学院'},
    	  {:sno => '201702', :sname => '李四', :sage => 34, :ssex => '女', :sdept => '数学学院'},
    	  {:sno => '201703', :sname => '刘爽', :sage => 23, :ssex => '女', :sdept => '网络安全学院'},
      	  {:sno => '201704', :sname => '张翰', :sage => 25, :ssex => '男', :sdept => '地球学院'},
      	  {:sno => '201705', :sname => '杨洋', :sage => 22, :ssex => '男', :sdept => '计算机与控制学院'},
      	  {:sno => '201706', :sname => '胡歌', :sage => 12, :ssex => '男', :sdept => '计算机与控制学院'},
  	 ]

students.each do |student|
  Student.create!(student)
end
