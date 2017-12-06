class StudentsController < ApplicationController
    def index
        
    end
    
    def create
        @student = Student.new(student_params)
        
        if @student.save
            redirect_to students_path, flash: {success:"学生添加成功"}
        else
            flash[:warning] = "信息填写有误！"
            render new
        end
        
    end
    
    def new
        @student = Student.new
    end
    
    def edit
        @studnet = Student.find_by(id: params[:id])
    end
    
    def show
        @studnet = Student.find_by(id: params[:id])
    end
    
    def update
        @student = find_by_id(params[:id])
        if @student.update_attributes(student_params)
            flash={:info => "更新成功" }
        else
            flash={:warning => "更新失败" }
        end
        redirect_to students_path, flash: flash
    end
    
    def destroy
        @student=Student.find_by_id(params[:id])
        @student.destroy
        flash={:success => "成功删除学生: #{@student.sname}"}
        redirect_to students_path, flash: flash
    end
end
