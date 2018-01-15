class TeachersController < ApplicationController
  
  #注册和登录不需要csrf鉴权
  skip_before_action :verify_authenticity_token, :only => [:create, :login]
  #教师入口，登录和注册不需要先登录
  skip_before_action :require_login, :only => [:create, :login, :entry]
  
  #教师入口
  def entry
  end
  
  #教师主页
  def index
    #获取我的课程信息
    @my_courses = Course.find_by_sql("select * from courses where teacher_id = #{session[:teacher_id]}")
  end

  #教师注册功能
  def create
    Rails.logger.info('----------teacher create start.-------------')

    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      #code = 0b0001
      flash ={:info => "恭喜您，注册成功" }
    else
      #code = 0b0000
      flash ={ :error => "注册失败,请重试" }
    end
    redirect_to teachers_entry_path, :flash => flash
  end
  
  #教师登录功能
  def login
    Rails.logger.info("teacher login start ")
    
    @teacher=Teacher.find_by(email: params[:email_1])
    if @teacher
      if @teacher[:password] == params[:password_1]
        session[:teacher_id] = @teacher.id
        session[:teacher_name] = @teacher.username
        
        flash = {:info => "登录成功,欢迎您，#{session[:teacher_name]}:)"}
        redirect_to teachers_path, :flash => flash
        return
      else
        #code = 0b0011
        flash = {:error => "登录失败：密码错误,请重试"}
      end
    else
      #code = 0b0000
      flash ={ :error => "登录失败：用户不存在" }
    end
      redirect_to teachers_entry_path, :flash => flash
  end

  #退出登录
  def destroy
    session[:teacher_id] = nil
    session[:teacher_name] = nil
      
    flash = {:success => "成功退出"}
    redirect_to teachers_entry_path, :flash => flash
  end
  
private
  def teacher_params
    params.permit(:username, :password, :email)
  end
  
end
