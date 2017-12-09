class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #数据库异常处理
  #异常处理
  rescue_from ActiveRecord::RecordNotUnique do |ex|
    code = 0b0010
    resp_msg = "该用户已注册"
    resp_json = "{\"code\":#{code}, \"message\":\"#{resp_msg}\", \"data\":{} }"
    render :text => "#{resp_json}"
  end
end
