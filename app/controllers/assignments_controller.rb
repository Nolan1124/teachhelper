#require "uuidtools"
require "securerandom"

class AssignmentsController < ApplicationController
    #skip_before_action :verify_authenticity_token, :only => [:addAssignment]
    before_action :verify_authenticity_token, :only => [:addAssignment, :showlist, :setDuration, :duration]
    
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
                redirect_to assignments_showlist_path 
            end
            format.json { render json: "#{resp_json}"}
        end
    end
    
    #显示任务列表
    def showlist
       @assignment = Assignment.find_by_sql("select b.c_id, b.cname, a.a_id, a.description, a.a_secret_key, a.duration from assignments a,courses b where a.course_id = b.c_id and b.t_id = '#{session[:teacher_id]}'")
        
        respond_to do |format|
            if @assignment
                flash = {:info => "添加成功"}
                format.html
                format.json { render json: @assignment }
            else
                flash = {:error => "添加失败"}
                format.html do
                    redirect_to  new_assignment_path, :flash => flash
                end
            end
        end 
    end
    
    def show
        
    end
    
    #设置密钥有效期
    def setDuration
        @assignment = Assignment.find_by(a_id: session[:a_id])
        
        if @assignment.update_attributes(:duration => params[:assignment][:screte_duration], :gmt_time => Time.current)
            #gmt_time为密钥开始时间，用于计算密钥有效期
            flash = {:info => "密钥开始有效，请及时向学生公布."}
        else
            flash = {:error => "密钥有效期设置错误."}
        end
        session[:a_id] = nil
        
        redirect_to assignments_duration_path, :flash => flash 
    end
    
    def duration
        session[:a_id] = params[:number] 
        print "seseeeeeeeeeeeeeeeeeeeeeee::::::::::::::", session[:a_id]
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
