class TeachersController < ApplicationController
  #支持html, json 
  require "responders"
  respond_to :html, :json
  
  #注册和登录不需要csrf鉴权
  skip_before_action :verify_authenticity_token, :only => [:create, :login]
  
  def new
    @teacher=Teacher.new
  end
  
  def show
  end

  #教师注册功能
  def create
    Rails.logger.info('----------teacher create start.-------------')

    @teacher = Teacher.new(teacher_params)
    
    if @teacher.save
      code = 0b0001
      resp_msg = "教师信息注册成功"
    else
      code = 0b0000
      resp_msg = "注册失败,请重试"
    end
    
    resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{} }"
    
    respond_to do |format|
      if code == 0b0001
        format.html do
          redirect_to teachers_path  #index
        end
        format.json { render json: "#{resp_json}"}
      else
        format.html do
          redirect_to teachers_register_path
        end
        format.json { render json: "#{resp_json}"}
      end
    end
  end
  
  #教师登录功能
  def login
    Rails.logger.info("teacher login start ")
    
    @teacher=Teacher.find_by(t_id: params[:teacher][:t_id])
    if @teacher
      if @teacher[:password] == params[:teacher][:password]
        session[:teacher_id] = @teacher.t_id
        code = 0b0001
        resp_msg = "登录成功"
        t_id = params[:teacher][:t_id]
        t_name = @teacher[:username]
      else
        code = 0b0011
        resp_msg = "密码错误"
      end
    else
      code = 0b0000
      resp_msg = "用户不存在，登录失败"
    end
    resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{\"t_id\":\"#{t_id}\", \"t_name\":\"#{t_name}\"} }"
    flash =  {:info => "#{resp_json}"}
    if code == 0b0001
        redirect_to teachers_main_path, :flash => flash
    else
        redirect_to teachers_path, :flash => flash
    end
  end
  
  def teacherMain
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

  #退出
  def destroy
      teacher_id = session[:teacher_id]
      session[:teacher_id] = nil
      flash = {:success => "#{teacher_id}成功退出"}
      redirect_to teachers_path, :flash => flash
  end

  def index
  end
  
  #注册静态页面
  def register
  end

  private

  def teacher_params
    params.require(:teacher).permit(:t_id, :username, :password, :eamil, :gmt_time)
  end
  
end
