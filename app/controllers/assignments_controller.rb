#require "uuidtools"
require "securerandom"

class AssignmentsController < ApplicationController
    #skip_before_action :verify_authenticity_token, :only => [:addAssignment]
    before_action :verify_authenticity_token, :only => [:add_assignment, :showlist, :setDuration, :duration]
    
    def new
    end
    
    #添加课堂任务
    def add_assignment
        Rails.logger.info('----------addAssignment  start.-------------')
     
        new_params = assignment_params
        new_params[:course_id] = session[:course_id]
        
        @assignment = Assignment.new(new_params)
        
        if @assignment.save
            flash ={ :info => "添加课堂任务成功" }
            #a_secret_key = new_params[:a_secret_key]
            redirect_to courses_path(:page => session[:course_id])
        else
            flash ={ :error =>"添加课堂任务失败" }
            redirect_to new_assignment_path
        end
    end
    
    #设置密钥有效期页面
    def duration
        session[:a_id] = params[:number] 
    end
    
    #创建密钥
    def build_secret_key
        a_id = session[:a_id]
        new_secret_key = create_secret_key
        if new_secret_key.nil?
            flash = {:error => "任务#{a_id}:密钥生成失败,请确认是否已登录"}
        else
            if set_duration a_id, new_secret_key
                flash = {:info => "任务#{a_id}:密钥开始有效，请及时向学生公布."}
            else
                 flash = {:error => "任务#{a_id}:密钥生成失败."}
            end
        end
        session[:a_id] = nil
        
        redirect_to courses_path(:page => session[:course_id]), :flash => flash
            
    end
    
    #设置密钥有效期
    def set_duration a_id, secret_key
        print "iddiiddididi:::::::", a_id
        @assignment = Assignment.find_by(id: a_id)
        
        #gmt_time为密钥开始时间，用于计算密钥有效期
        if @assignment.update_attributes(:secret_key => secret_key,:duration => params[:assignment][:duration], :gmt_time => Time.current)
            return true
        else
            return false
        end
    end
    
    def destroy
        @assignment = Assignment.find(params[:id])
        @assignment.destroy
        flash = { :info => "课程任务#{@assignment.id}删除成功"}
        
        redirect_to courses_path(:page => session[:course_id]), :flash => flash
    end
    
private
    def assignment_params
        a_params = params.require(:assignment).permit(:course_id, :content, :answer, :secret_key, :duration, :gmt_time)
        return a_params
        #if a_params[:secret_key] = createSecretKey
        #    return a_params
        #else
        #    return nil
        #end
    end
    
    def create_secret_key
        if teacher_id =  session[:teacher_id]
            #生成密钥，格式：A + t_id + 8位uuid
            uuid = SecureRandom.hex(4)
            print "uuid::::::::::" ,uuid
            secret_key = "A" + teacher_id.to_s + uuid
            return secret_key
        else
            return nil
        end
    end
    
    
    
end
