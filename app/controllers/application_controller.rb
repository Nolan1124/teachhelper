class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #异常处理
  def rescue_action_in_public(exception)
    Rails.logger.error("rescue_action_in_public exe")
    case exception
    when ActiveRecord::RecordNotUnique, ::ActionController::RoutingError
      code = 0b1000
      resp_msg = "数据异常"
      resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{} }"
      
      respond_to do |format|
        format.json { render json: "#{resp_json}"}
      end
    else
      code = 0b1111
      resp_msg = "未知异常"
      resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{} }"
      
      respond_to do |format|
        format.json { render json: "#{resp_json}"}
      end
    end
  end
  
  #数据库插入异常
  rescue_from ActiveRecord::RecordNotUnique do |ex|
    code = 0b0010
    resp_msg = "数据已添加，不能重复添加"
    resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{} }"
    
    respond_to do |format|
      format.json { render json: "#{resp_json}"}
    end
  end
  
  #before_action :require_login
 
  #private
 
  #def require_login
   # unless logged_in?
    #  flash[:error] = "你必须先登录"
     # redirect_to new_role_path 
    #end
  #end
  
end
