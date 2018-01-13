class HomeController < ApplicationController
    #处理角色界面
    def index
    end
    
    #处理角色处理流程
    def create
        role = params[:role][:rolename]
        if role == '学生' then
            redirect_to :controller => 'students', :action => 'index'
        elsif role == '教师' then
            redirect_to :controller => 'teachers', :action => 'index'
        else
            flash[:error] = "请选择正确角色"
            redirect_to :controller => 'roles', :action => 'new', :flash => flash
        end
    end
    
  private
  #def roles_params
   #params.require(:roles).permit(:rolename)
  #end
end
