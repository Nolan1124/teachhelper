class CoursesController < ApplicationController
    #跳过csrf验证，方便测试
    skip_before_action :verify_authenticity_token, :only => [:addCourse]
    def addCourse
        Rails.logger.info('----------addCourse  start.-------------')
    
        @course = Course.new(course_params)
        if @course.save
            code = 0b0001
            resp_msg = "添加课程成功"
        else
            code = 0b0000
            resp_msg = "添加课程失败"
        end
        resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{} }"
        
        respond_to do |format|
            format.json { render json: "#{resp_json}"}
        end
    end
    
    def course_params
        params.require(:course).permit(:c_id, :t_id, :cname, :year, :season, :gmt_time)
    end
    
end
