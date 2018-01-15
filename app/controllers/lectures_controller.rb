class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy]

  def add
    
  end
  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.all
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
  end

  # GET /lectures/1/edit
  def edit
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url, notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # POST /lectures
  # POST /lectures.json
  def create
    @lecture=Lecture.new(lecture_params)
    unless request.get?
			file_name = uploadfile(lecture_params[:url])			
			
			@lecture.url= file_name
			@lecture.secret_key=createSecretKey(@lecture.course_id)
			@lecture.save
		end
		redirect_to lectures_path
  end
  
  def findkey
    key=session[:secret_key]
    lectures = Lecture.find_by(secret_key: key)
    return lectures
  end
  
  def download
    @file_name=@lectures.url
    url="#{Rails.root}/public/upload/#{@file_name}"
    #send_file("#{Rails.root}/public/upload/#{@file_name}") unless params[:url].blank? 
    
    file_path = url
    if File.exist?(file_path)
        io = File.open(file_path)
        io.binmode
        send_data(io.read,:filename => @file_name,:disposition => 'attachment')
        io.close
    end
    
  end
  
  
  ##上传文件
  ##file.original_filename 获取文件名字
  protected
  def uploadfile(file)
    if !file.original_filename.empty?
      @filename = file.original_filename
      #设置目录路径，如果目录不存在，生成新目录
      FileUtils.mkdir("#{Rails.root}/public/upload") unless File.exist?("#{Rails.root}/public/upload")
      #写入文件  #wb 表示通过二进制方式写，可以保证文件不损坏
      File.open("#{Rails.root}/public/upload/#{@filename}", "wb") do |f|
        f.write(file.read)
      end
      return @filename
    end
  end
 
  def createSecretKey(course_id)
          #生成密钥，格式：A + t_id + 8位uuid
          #uuid = UUIDTools::UUID.random_create.to_s
          uuid = SecureRandom.hex(4)
          print "uuid::::::::::" ,uuid
          secretKey = "L" + course_id.to_s + uuid
          return secretKey
  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lectures = Lecture.find_by(secret_key: session[:secret_key])
      #@lecture = Lecture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:course_id, :lecture_name, :url)
      #params.fetch(:lecture, {})
    end
end
