class SessionsController < ApplicationController
    include SessionsHelper
    def new
        
    end
    def create
        key=params[:session][:secret_key]
        if ifAkey(key) then
            ass=Assignment.find_by(secret_key: key)
            if(ass)
                #判断密钥是否在生存期内
                #time_now=Time.now.strftime('%Y%m%d%H%M%S')
                #if time_now-ass.gmt_time < ass.duration then
                    flash[:notice] = key
                    session[:secret_key]=key
                    redirect_to "/solutions/new"
                #else
                #    flash[:notice] = "密钥超时!!!"
                #    render "new"
                #end
            else
                flash[:notice] = "密钥不存在!!!"
                render "new"
            end

        elsif ifLkey(key) then
            lec=Lecture.find_by(secret_key: key)
            if lec
                flash[:notice] = key
                session[:secret_key]=key
                redirect_to lecture_path(key)
            else
                flash[:notice] = "密钥不存在!!!"
                render "new"
            end
        
        else
            flash[:notice] = "密钥格式错误!!!"
            render "new"
        end
    end
    
    def destroy
      session[:secret_key] = nil
      redirect_to root_path
    end
    def findALLkey
        ass=Assignment.find_by_sql("select * from assignments")
        return ass
    end
    def findLecALLkey
        lec=Lecture.find_by_sql("select * from lectures")
        return lec
    end
    def ifAkey(key)
        if !key.empty? and key[0]=='A'
            return true
        else
            return false
        end
    end
    def ifLkey(key)
        if !key.empty? and key[0]=='L'
            return true
        else
            return false
        end
    end
end
