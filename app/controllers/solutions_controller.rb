class SolutionsController < BaseApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_solution, only: [:show, :edit, :update, :destroy]


  # GET /solutions/new
  def new
    if session[:secret_key].nil? then
      redirect_to root_path
    end
    @solution = Solution.new
  end



  # POST /solutions
  # POST /solutions.json
  def create
    @solution = Solution.new(solution_params)
    #找出正确答案
    id=@solution.assignment_id
    assignment=Assignment.find_by_id(id)
    
    if assignment
      real_answer = assignment.answer.upcase
      answer=@solution.student_answer.upcase
      #对比得到成绩
      @solution.score=comp_string(real_answer,answer)
      session[:secret_key] = nil
      if @solution.save
        flash[:notice] = "提交成功，本次课堂成绩得到 #{@solution.score.to_s} 分！！"
        redirect_to "/sessions/new"
      else
        flash[:notice] ="提交保存出现错误，请联系老师说明原因！！"
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "没有找到课堂任务！！"
      redirect_to "/sessions/new"
    end
  end
  
  def comp_string(real_answer,answer)
    len=real_answer.length
    i=0
    acc=0
    while i < len do
      	if( real_answer[i]==(answer[i]) )
        	acc+=1
      	end
      	i+=1
    end
    return ((acc/len.to_f)*100).to_i
  end
  

  def score
    if session[:secret_key].nil? then
      redirect_to root_path
    else
      
    end
  end
  
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      #@solution = Solution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.permit(:assignment_id, :student_answer, :student_id, :student_name, :score)
      #params.fetch(:solution, {})
    end
end
