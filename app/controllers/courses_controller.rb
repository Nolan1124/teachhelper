class CoursesController < ApplicationController
    #跳过csrf验证，方便测试
    #skip_before_action :verify_authenticity_token, :only => [:addCourse]
    
    #课程页面
    def index
        #获取该门课程的课堂任务
        course_id = params[:page]
        session[:course_id] = course_id
        
        @course_name = Course.find_by_id(course_id)
        
        @assignments_by_course = Assignment.find_by_sql("select * from assignments where course_id = #{course_id}")
        
        @lectures_by_course = Lecture.find_by_sql("select * from lectures where course_id = #{course_id}")
        
    end
    
    def course_detail
        
    end
    
    def new 
    end
    
    #添加课程
    def add_course
        Rails.logger.info('----------addCourse  start.-------------')
    
        @course = Course.new(:name => params[:course][:name], :teacher_id => session[:teacher_id])
        if @course.save
            #code = 0b0001
            flash ={:info => "添加课程成功"}
        else
            #code = 0b0000
            flash ={:error => "添加课程失败"}
        end
        
        redirect_to teachers_path
    end
    
    
    def edit_course
        
    end
    
    #删除课程信息
    def destroy
        @course = Course.find(params[:id])
        @course.destroy
        flash = { :info => "课程#{@course.name}删除成功"}
        
        redirect_to teachers_path, :flash => flash
    end
    
    def course_params
        params.require(:course).permit(:name)
    end
    
end
