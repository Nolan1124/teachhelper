#require "uuidtools"
require "securerandom"

class AssignmentsController < ApplicationController
    #skip_before_action :verify_authenticity_token, :only => [:addAssignment]
    #before_action :verify_authenticity_token, :only => [:addAssignment]
    
    def new
    end
    
    def addAssignment
        Rails.logger.info('----------addAssignment  start.-------------')
     
        unless new_params = assignment_params
            code = 0b1001
            resp_msg = "秘钥生成失败"
            resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{\"secretKey\":\"\"} }"
        
            respond_to do |format|
                format.html do 
                    redirect_to assignments_addassignment_path
                end
                format.json { render json: "#{resp_json}"}
            end
            
            return
        end
        
        @assignment = Assignment.new(new_params)
        
        if @assignment.save
            code = 0b0001
            resp_msg = "添加课堂任务成功"
            a_secret_key = new_params[:a_secret_key]
        else
            code = 0b0000
            resp_msg = "添加课堂任务失败"
            a_secret_key = ""
        end
        
        resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{\"secretKey\":\"#{a_secret_key}\"} }"
        
        respond_to do |format|
            format.html do 
                redirect_to assignments_show_path, :data => resp_json.to_json
            end
            format.json { render json: "#{resp_json}"}
        end
    end
    
    #显示任务列表
    def show
        #@assignment = Assignment.find_by_sql()
    end
    
private
    def assignment_params
        print "start assignment_params"
        a_params = params.require(:assignment).permit(:a_id, :course_id, :description, :a_secret_key, :duration, :gmt_time)
        if a_params[:a_secret_key] = createSecretKey
            return a_params
        else
            return nil
        end
    end
    
    def createSecretKey
        print "start createSecretKey::::::::::::::::", session[:teacher_id]
        if teacher_id =  session[:teacher_id] #params[:assignment][:t_id]
            #生成密钥，格式：A + t_id + 8位uuid
            #uuid = UUIDTools::UUID.random_create.to_s
            uuid = SecureRandom.hex(4)
            print "uuid::::::::::" ,uuid
            secretKey = "A" + teacher_id.to_s + uuid
            return secretKey
        else
            return nil
        end
    end
    
    
    
end
