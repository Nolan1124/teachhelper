class TeachersController < ApplicationController
  #支持html, xml ,json 
  #respond_to :html, :xml, :json
  
  #跳过csrf验证，方便测试
  skip_before_action :verify_authenticity_token, :only => [:create, :login]
  
  def new
    @teacher=Teacher.new
    #respond_with @teacher
  end

  #教师注册功能
  def create
    Rails.logger.info('----------teacher create start.-------------')
    #json_receive = params[:teacher]
    #teacher_params = ActiveSupport::JSON.decode(json_receive)
    resp_msg = ""
    code = 0b0000
    resp_json = ""
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      code = 0b0001
      resp_msg = "教师信息注册成功"
      resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{} }"
      #redirect_to teachers_path, flash: {success: "教师注册成功"}
    else
      code = 0b0000
      resp_msg = "注册失败,请重试"
      resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{} }"
    end
    render :text => "#{resp_json}"
  end
  
  #教师登录功能
  def login
    Rails.logger.info("teacher login start ")
    @teacher=Teacher.find_by(t_id: params[:teacher][:t_id])
    if @teacher
      if @teacher[:password] == params[:teacher][:password]
        code = 0b0001
        resp_msg = "登录成功"
      else
        code = 0b0011
        resp_msg = "密码错误"
      end
    else
      code = 0b0000
      resp_msg = "用户不存在，登录失败"
    end
    
    resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{} }"
    render :text => "#{resp_json}"
  end

  def edit
    @teacher=Teacher.find_by(id: params[:id])
  end

  def update
    @teacher = Teacher.find_by_id(params[:id])
    if @teacher.update_attributes(teacher_params)
      flash={:info => "教师信息更新成功"}
    else
      flash={:warning => "教师信息更新失败"}
    end
    redirect_to teachers_path, flash: flash
  end

  def destroy
    @teacher=Teacher.find_by_id(params[:id])
    @teacher.destroy
    flash={:success => "成功删除教师信息: #{@teacher.username}"}
    redirect_to teachers_path, flash: flash
  end

  def index
    #@teacher=Teacher.all
  end

  private

  def teacher_params
    params.require(:teacher).permit(:t_id, :username, :password, :eamil, :gmt_time)
  end
  
end
