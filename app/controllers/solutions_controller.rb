class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]

  # GET /solutions
  # GET /solutions.json
  def index
    @solutions = Solution.all
  end

  # GET /solutions/1
  # GET /solutions/1.json
  def show
  end

  # GET /solutions/new
  def new
    if session[:secret_key].nil? then
      redirect_to root_path
    end
    @solution = Solution.new
  end

  # GET /solutions/1/edit
  def edit
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
      if @solution.save
        flash[:warning] = @solution.score.to_s
        redirect_to :action => "score", :value => @solution.score
      else
        flash[:warning] ="save error"
        render "new"
      end
    else
      flash[:warning] = "find error"
      render "new"
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
  
  # PATCH/PUT /solutions/1
  # PATCH/PUT /solutions/1.json
  def update
    respond_to do |format|
      if @solution.update(solution_params)
        format.html { redirect_to @solution, notice: 'Solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @solution }
      else
        format.html { render :edit }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solutions/1
  # DELETE /solutions/1.json
  def destroy
    @solution.destroy
    respond_to do |format|
      format.html { redirect_to solutions_url, notice: 'Solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      #@solution = Solution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:assignment_id, :student_answer, :student_id, :student_name, :score)
      #params.fetch(:solution, {})
    end
end
