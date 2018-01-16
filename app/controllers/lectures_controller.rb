class LecturesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_lecture, only: [:edit, :update, :destroy]

  def add
    
  end
  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.all
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
  end
  
  def destroy
    @lecture=Lecture.find_by(secret_key: params[:id])
    @lecture.destroy
    flash = { :info => "讲义#{@lecture.lecture_name}删除成功"}
    redirect_to courses_path(:page => params[:page]), :flash => flash
  end
  
  # POST /lectures
  # POST /lectures.json
  def create
    @lecture=Lecture.new(lecture_params)
    unless request.get?
			file_name = uploadfile(lecture_params[:url])			
			@lecture.url= "/upload/#{file_name}"
			@lecture.secret_key=createSecretKey(@lecture.course_id)
			@lecture.save
		end
		redirect_to courses_path(:page => @lecture.course_id)
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
      params.permit(:course_id, :lecture_name, :url)
      #params.fetch(:lecture, {})
    end
end
